%------------------------------------------------------------------------%
% 
% This code computes DS-weights and welfare assessments for labor income
% tax policy in the canonical Huggett (1993) model.
% 
% Code written by Sergi Barcons, Eduardo Davila and Andreas Schaab.
% Current version: March 2023. First version: August 2022.
% 
% If you find this code helpful in your own work, please cite:
% - Davila, E. and A. Schaab. Welfare Assessments with Heterogeneous
%   Individuals. Working Paper
% - Schaab, A. and A. T. Zhang. Dynamic Programming in Continuous Time 
%   with Adaptive Sparse Grids. Working Paper.
% Thanks!
% 
%------------------------------------------------------------------------%

clear
close all
clc

diary ./output/output.log
diary on

addpath(genpath('../../../SparseEcon/'))
figure_format;

fprintf('Running algorithm:\n')
run_time = tic;


%% PARAMETERS

param = define_parameters();

%% INITIALIZE GRIDS

% Dense grid:
G_dense = setup_grid(param.l_dense, 0, param.min, param.max, 'NamedDims', {1}, 'Names', {'a'});
G_dense.dx = G_dense.da;

% Sparse grid:
G = setup_grid(param.l, 0, param.min, param.max, 'NamedDims', {1}, 'Names', {'a'});

% Projection matrix:
G.BH_dense = get_projection_matrix(G_dense.grid, G_dense.lvl, G);


%% COMPUTE STATIONARY EQUILIBRIA ACROSS POLICIES
ss = cell(param.num_theta, 1); % each cell stores data for one policy

fprintf('\n\n:::::::::::   STATIONARY EQUILIBRIUM   ::::::::::: \n\n');

for j = 1:param.num_theta
    
    param.theta = param.theta_min + (j-1)/(param.num_theta-1) * (param.theta_max - param.theta_min);
    G.theta(j) = param.theta;
    
    r0 = 0.002; if j > 1, r0 = ss{j-1}.r; end; X0 = r0;
    
    % Get better guess for value function:
    [diff0, G, G_dense, ~] = stationary(X0, G, G_dense, param);
    
    % Solve for steady state prices:
    options = optimset('Display', 'off', 'UseParallel', false, 'TolX', 1e-12);
    X = fsolve(@(x) stationary(x, G, G_dense, param), X0, options);
    
    % Solve with correct prices:
    [~, G, G_dense, ss{j}] = stationary(X, G, G_dense, param);
    ss{j}.theta = param.theta;
    
    fprintf('Stationary Equilibrium: r = %.4f,  markets(B = %.2d,  S = %.2d,  Y-C = %.2d) \n\n', ...
        ss{j}.r, ss{j}.B, ss{j}.S, ss{j}.excess_supply);
end

% Initial density
G.g = ss{1}.g(:);

%% COMPUTE TRANSITION DYNAMICS
fprintf('\n\n:::::::::::   TRANSITION DYNAMICS   ::::::::::: \n\n');

fprintf('Impulse response paths:  %.i quarters,  %.i time steps,  using %.i %s BFs\n\n', ...
         param.T, param.N, param.H(1), param.bfun_type);

for j = 1:param.num_theta
    
    param.theta = G.theta(j);

    % Initialize paths and grid: (guessing path for r)
    X0 = ss{j}.r .* ones(param.N, 1);
    [PHI0, param.nodes] = basis_fun_irf(X0, [], param.H(1), param.H(2), ...
        param.bfun_type, param.t, "get_coefficient");

    [diff0, G, G_dense, ~] = transition(PHI0, G, G_dense, ss{j}, param);

    % Solve for prices:
    f = @(x, y) transition(x, y{1}, y{2}, ss{j}, param); y0{1} = G; y0{2} = G_dense;
    PHI{j} = fsolve_newton(f, reshape(PHI0, [numel(PHI0), 1]), diff0, y0, 0, 5, 2);

    % Update everything given new prices:
    %[diff, G, G_dense, sim{j}] = transition(PHI, G, G_dense, ss{j}, param);
    %sim{j}.PHI = PHI; sim{j}.param = param;

end

fprintf('Update everithing given new prices in a finer grid. \n\n');

old_t_grid = param.t;
param = define_parameters('N', param.N_fine);
param.old_t = old_t_grid;

for j = 1:param.num_theta
    
    param.theta = G.theta(j);
        
    param.nodes = param.t;
    PHI_finer = interp1(param.old_t, PHI{j}, param.t);

    % Update everything given new prices:
    [diff, G, G_dense, sim{j}] = transition(PHI_finer, G, G_dense, ss{j}, param);
    sim{j}.PHI = PHI; sim{j}.param = param; sim{j}.diff = diff;

end

% Normalize initial density
G.g = G.g .* G_dense.dx;


%% AGGREGATE ADDITIVE DECOMPOSITION

fprintf('\n\n:::::::::::   AGGREGATE ADDITIVE DECOMPOSITION   ::::::::::: \n\n');

[AE, RS, IS, RE, norm_factor] = additive_decomp(G, sim, ss, param);

% Save as vectors to plot them
[vec_AE, vec_RS, vec_IS, vec_RE] = deal(zeros(param.num_theta, 1));
for j = 1:param.num_theta
    vec_AE(j) = AE{j}; vec_RS(j) = RS{j}; vec_IS(j) = IS{j}; vec_RE(j) = RE{j};
end
dW = vec_AE + vec_RS + vec_IS + vec_RE;

% Check error
max_error=0;
for j = 1:param.num_theta-1
    dW_hjb = (ss{j+1}.V(:) - ss{j}.V(:))' * ss{1}.g(:) / param.dtheta;
    max_error = max(max_error, abs(dW_hjb - norm_factor{j} * dW(j)));
end
warning('\nMaximum error dW is %.5f', max_error);


%% PLOT

figure; hold on;
%set(gcf,'position',[440 387 400 400])
l0 = plot(G.theta(1:param.num_theta-1), dW(1:param.num_theta-1),'color',[255,188,000]./255);
l1 = plot(G.theta(1:param.num_theta-1), vec_AE(1:param.num_theta-1),'m--');
l2 = plot(G.theta(1:param.num_theta-1), vec_RS(1:param.num_theta-1),'c:');
l3 = plot(G.theta(1:param.num_theta-1), vec_IS(1:param.num_theta-1),'-.','color',[000,076,153]./255);
l4 = plot(G.theta(1:param.num_theta-1), vec_RE(1:param.num_theta-1),'--','color',[202,091,035]./255);
hold off;
xlim([0, G.theta(param.num_theta-1)])
xlabel('$\theta$ (policy)','Interpreter','Latex','Fontsize',16);
title('Marginal Welfare Assessments','Interpreter','Latex','Fontsize',16);
legend([l0, l1, l2, l3, l4], {'$\frac{dW}{d\theta}$', '$\Xi_{AE}$ (Agg. Efficiency)', '$\Xi_{RS}$ (Risk-Sharing)', '$\Xi_{IS}$ (Inter.-Sharing)', '$\Xi_{RD}$ (Redistribution)'}, ...
        'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast');
exportgraphics(gcf, './output/agg_additive_decomposition.eps');
    

    
%% OUTPUT
run_time = toc(run_time); fprintf('\n\nAlgorithm converged. Run-time of: %.2f seconds.\n', run_time);

% fprintf('\nPlotting Figures...\n');
% for n = 1:adapt_iter
%     
%     figure('visible', 'off'); hold on;
%     l1 = scatter(G_adapt{n}.a, V_adapt{n}(:, 1)); 
%     l2 = scatter(G_adapt{n}.a, V_adapt{n}(:, 2)); 
%     hold off; xlabel('Wealth');
%     legend([l1, l2], {'$V^U(a)$','$V^E(a)$'}, 'Interpreter', 'Latex', 'box', 'off', 'Location', 'SouthEast');
%     exportgraphics(gcf, ['./output/grid_adaptation', num2str(n-1), '.eps']);
% 
% end

diary off




