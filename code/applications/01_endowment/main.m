%------------------------------------------------------------------------%
% 
% This code computes DS-weights and welfare assessments for transfer policy
% in an endowment economy.
% 
% Code written by Eduardo Davila and Andreas Schaab.
% Current version: August 2022. First version: August 2022.
% 
% If you find this code helpful in your own work, please cite:
% - Davila, E. and A. Schaab. Welfare Assessments with Heterogeneous
%   Individuals. Working Paper.
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

addpath(genpath('../../SparseEcon/'))
figure_format;

fprintf('Running algorithm:\n')
run_time = tic;


%% PARAMETERS
param = define_parameters('la1', 1/3, 'la2', 1/3);


%% INITIALIZE GRID
G.z = [param.z1, param.z2];

% Transition rates for endowment process (policy-invariant):
G.Az = [-speye(1)*param.la1,  speye(1)*param.la1; ...
         speye(1)*param.la2, -speye(1)*param.la2];

% Stationary distribution (policy-invariant):
% G.g2 = KF(G.Az, G, param);
G.g = [param.la2/(param.la1+param.la2), param.la1/(param.la1+param.la2)];


%% COMPUTE COMPETITIVE EQUILIBRIA ACROSS POLICIES
CE = cell(param.num_theta, 1); % each cell stores data for one policy

for j = 1:param.num_theta

    % Initialize policy stance:
    CE{j}.theta = 0 + (j-1)/(param.num_theta-1);

    % Transfer policy, income, and consumption:
    CE{j}.T = 1 - G.z;
    CE{j}.income = G.z + CE{j}.theta * CE{j}.T;
    CE{j}.c = CE{j}.income;
    CE{j}.u = param.u(CE{j}.c);
    CE{j}.u1 = param.u1(CE{j}.c);

    % Initialize guess V0:
    CE{j}.V0 = param.u(CE{j}.c) / param.rho;
    
    % Solve VFI:
    CE{j}.V = VFI(CE{j}, G, param);
    
end


%% TRANSITION DENSITIES

% Transition densities are policy-invariant
P = cell(param.N, 1);
P{1} = eye(2, 2);

P2 = P; P3 = P;

for j = 1:2
for n = 1:param.N-1
    % Explicit time iteration:
    P2{n+1}(:, j) = P2{n}(:, j) + param.dt * G.Az' * P2{n}(:, j);
    
    % Implicit time iteration:
    B = 1/param.dt .* speye(2) - G.Az';
    b = P{n}(:, j) / param.dt;
    
    P{n+1}(:, j) = B\b;
end
end

% For explicit, we can iterate on the matrix directly:
for n = 1:param.N-1
    % Explicit time iteration:
    P3{n+1} = P3{n} + param.dt * G.Az' * P3{n};
    
    % Implicit time iteration:
    % B = 1/param.dt .* speye(2) - G.Az';
    % b = P{n} / param.dt;    
    % P{n+1} = B\b;
end


%% COMPUTE DS-WEIGHTS (for normalized utilitarian)

% Modified discount factor: 
beta = param.dt * exp(-param.rho * param.t);

% Initialize data structure:
omega_ind = cell(param.num_theta, 1);
omega_dyn = cell(param.num_theta, 1);
omega_sto = cell(param.num_theta, 1);

% Pareto weights:
alpha = ones(2, 1);

% Note: we want allocation objects to be column vectors now

% Compute components:
for j = 1:param.num_theta
    
    % Weighted marginal utilities:
    weighted_u1 = zeros(2, param.N);
    for n = 1:param.N
        weighted_u1(:, n) = beta(n) * P{n}' * reshape(CE{j}.u1, [2, 1]);
    end
    
    % Individual component:
    omega_ind{j} = alpha .* sum(weighted_u1, 2) ./ ...
                   (G.g * (alpha .* sum(weighted_u1, 2)));
    
    % Dynamic component:
    omega_dyn{j} = zeros(2, param.N);
    for n = 1:param.N
        omega_dyn{j}(:, n) = weighted_u1(:, n) ./ sum(weighted_u1, 2);
    end

    % Stochastic component:
    for n = 1:param.N
        omega_sto{j}{n} = P{n} .* (CE{j}.u1') ./ (P{n}' * (CE{j}.u1'))';
    end

end


%% INSTANTANEOUS CONSUMPTION-EQUIVALENT EFFECT
duc = cell(param.num_theta, 1);
for j = 1:param.num_theta - 1
    
    duc{j} = (CE{j+1}.c - CE{j}.c) ./ (CE{j+1}.theta - CE{j}.theta);
    duc{j} = reshape(duc{j}, [2, 1]);

end
duc{param.num_theta} = duc{param.num_theta - 1};


%% AGGREGATE ADDITIVE DECOMPOSITION

[AE, RS, IS, RE] = deal(cell(param.num_theta, 1));

g = reshape(G.g, [2, 1]);

for j = 1:param.num_theta

    % Aggregate efficiency:
    AE{j} = 0; 
    for n = 1:param.N
        AE{j} = AE{j} + (omega_ind{j}' * g) * (omega_dyn{j}(:, n)' * g) * (sum( (omega_sto{j}{n} * g) .* duc{j} ));
    end
    
    % Risk-sharing:
    %RS =
    
    % Intertemporal-sharing:
    %IS = 
    
    % Redistribution: 
    %RE = 

end


%% OUTPUT
run_time = toc(run_time); fprintf('\n\nAlgorithm converged. Run-time of: %.2f seconds.\n', run_time);

fprintf('\nPlotting Figures...\n');

figure; hold on;
l1 = plot(G.z', G.V0');
l2 = plot(G.z', V');
hold off;
legend([l1, l2], {'Value function: permanent', ['Value function: $\theta=$', num2str(theta)]}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'SouthEast')


diary off




