%------------------------------------------------------------------------%
% 
% This code computes DS-weights and welfare assessments for savings tax
% policy in the canonical Huggett (1993) model.
% 
% Code written by Eduardo Davila and Andreas Schaab.
% Current version: August 2022. First version: August 2022.
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

addpath(genpath('../../../lib/'))
figure_format;

fprintf('Running algorithm:\n')
run_time = tic;


%% PARAMETERS

param = define_parameters();

param.theta = 0.25;


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

for j = 1:param.num_theta
    
    param.theta = param.theta_min + (j-1)/(param.num_theta-1) * (param.theta_max - param.theta_min);
    
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


%% TRANSITION DENSITIES

if G.J ~= G_dense.J, error('Sparse grids not yet accommodated\n'); end

% Transition densities vary with the policy
P = cell(param.num_theta, 1);
for j = 1:param.num_theta
    P{j} = cell(param.N, 1);
    P{j}{1} = eye(param.discrete_types * G.J, param.discrete_types * G.J);

    % Explicit time iteration:
    for n = 1:param.N-1
        P{j}{n+1} = P{j}{n} + param.dt * ss{j}.A' * P{j}{n};
    end
end


%% OUTPUT
run_time = toc(run_time); fprintf('\n\nAlgorithm converged. Run-time of: %.2f seconds.\n', run_time);

fprintf('\nPlotting Figures...\n');
for n = 1:adapt_iter
    
    figure('visible', 'off'); hold on;
    l1 = scatter(G_adapt{n}.a, V_adapt{n}(:, 1)); 
    l2 = scatter(G_adapt{n}.a, V_adapt{n}(:, 2)); 
    hold off; xlabel('Wealth');
    legend([l1, l2], {'$V^U(a)$','$V^E(a)$'}, 'Interpreter', 'Latex', 'box', 'off', 'Location', 'SouthEast');
    exportgraphics(gcf, ['./output/grid_adaptation', num2str(n-1), '.eps']);

end

diary off




