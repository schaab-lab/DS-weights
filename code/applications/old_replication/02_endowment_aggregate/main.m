%------------------------------------------------------------------------%
% 
% This code computes DS-weights and welfare assessments for transfer policy
% in an endowment economy with aggregate risk (section 7, scenario 2).
% 
% Code written by Sergi Barcons, Eduardo Davila and Andreas Schaab.
% Current version: Januray 2023. First version: Januray 2023.
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

addpath(genpath('../../../SparseEcon/'))
figure_format;

fprintf('Running algorithm:\n')
run_time = tic;

%% PARAMETERS
param = define_parameters('la1', -log(0.975), 'la2', -log(0.975));
%param = define_parameters('la1', -log(0.999), 'la2', -log(0.999));
%param = define_parameters('la1', -log(0.5), 'la2', -log(0.5));

%% INITIALIZE GRID
G.z = [param.z1, param.z2];

% Transition rates for endowment process (policy-invariant):
G.Az = [-speye(1)*param.la1,  speye(1)*param.la1; ...
         speye(1)*param.la2, -speye(1)*param.la2];

%% COMPUTE COMPETITIVE EQUILIBRIA ACROSS POLICIES
CE_ = cell(param.num_theta, param.num_indiv); % each cell stores data for one policy and one type of agents

for i = 1:param.num_indiv
    for j = 1:param.num_theta

        % Initialize policy stance:
        CE_{j,i}.theta = param.theta_min + (param.theta_max - param.theta_min) * (j-1)/(param.num_theta-1);

        % Transfer policy, income, and consumption:
        if i==1, CE_{j,i}.T = 1 - G.z; else, CE_{j,i}.T = G.z - 1; end
        CE_{j,i}.income = G.z + CE_{j,i}.theta * CE_{j,i}.T;
        CE_{j,i}.c  = CE_{j,i}.income;
        CE_{j,i}.u  = param.u(CE_{j,i}.c,param.gamma(i));
        CE_{j,i}.u1 = param.u1(CE_{j,i}.c,param.gamma(i));

        % Initialize guess V0:
        CE_{j,i}.V0 = param.u(CE_{j,i}.c,param.gamma(i)) / param.rho;

        % Solve VFI:
        CE_{j,i}.V = VFI(CE_{j,i}, G, param);

    end
end

CE  = cell(param.num_theta, 1); % each cell stores data for one policy
for i = 1:param.num_indiv
    for j = 1:param.num_theta
        CE{j}.c(i,:)  = CE_{j,i}.c;
        CE{j}.u(i,:)  = CE_{j,i}.u;
        CE{j}.u1(i,:) = CE_{j,i}.u1;
        CE{j}.V(i,:)  = CE_{j,i}.V;
        CE{j}.theta   = param.theta_min + (param.theta_max - param.theta_min) * (j-1)/(param.num_theta-1);
    end
end

%% TRANSITION DENSITIES
% Transition densities are policy-invariant
P = cell(param.N, 1);
P{1} = eye(2, 2);
P2 = P; P3 = P;

for j = 1:param.discrete_types
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
omega_ind      = cell(param.num_agg, param.num_theta, param.num_phi, param.num_indiv);
omega_dyn      = cell(param.num_theta, param.num_phi, param.num_indiv);
omega_sto      = cell(param.num_theta, param.num_phi, param.num_indiv);
omega_sto_norm = cell(param.num_theta, param.num_phi, param.num_indiv);

% Note: we want allocation objects to be column vectors now

% Compute components:
alpha = cell(param.num_indiv, param.num_phi);
weighted_u1 = cell(param.num_indiv, 1);
for i = 1:param.num_phi
    for j = 1:param.num_theta
        
        for k = 1:param.num_indiv
            % Pareto weights:
            alpha{k,i} = param.pareto(ones(2,1),CE{j}.V(k,:),param.phi(i));
            
            % Weighted marginal utilities:
            weighted_u1{k} = zeros(2, param.N);
            for n = 1:param.N 
                weighted_u1{k}(:, n) = beta(n) * P{n}' * reshape(CE{j}.u1(k,:), [2, 1]);
            end
        end
        
        for k = 1:param.num_indiv
            if k == 1, k_ = 2; else, k_ = 1; end

            % Individual component:
            for z = 1:param.num_agg
                if z == 1, G.g = [1, 0]; else, G.g = [0, 1]; end

                    omega_ind{z,j,i,k} = alpha{k,i} .* sum(weighted_u1{k}, 2) ./ ...
                           ( .5 * G.g * (alpha{k,i} .* sum(weighted_u1{k}, 2)) + ...
                             .5 * G.g * (alpha{k_,i} .* sum(weighted_u1{k_}, 2)));
            end

            % Dynamic component:
            omega_dyn{j,i,k} = zeros(2, param.N);
            for n = 1:param.N
                omega_dyn{j,i,k}(:, n) = weighted_u1{k}(:, n) ./ (.5 * sum(weighted_u1{k}, 2));
            end

            % Stochastic component: 
            for n = 1:param.N
                omega_sto{j,i,k}{n} = .5 * ( P{n} .* (CE{j}.u1(k,:)') ./ (P{n}' * (CE{j}.u1(k,:)'))' )';
                omega_sto_norm{j,i,k}{n} = .5 * ( (CE{j}.u1(k,:)')' ./ sum((CE{j}.u1(k,:)')' .* P{n}, 2) )';
            end
        end
    end
end

%% INSTANTANEOUS CONSUMPTION-EQUIVALENT EFFECT
duc = cell(param.num_theta, param.num_indiv);
for j = 1:param.num_theta
    for i = 1:param.num_indiv
        if j < param.num_theta
            duc{j,i} = (CE{j+1}.c(i,:) - CE{j}.c(i,:)) ./ (CE{j+1}.theta - CE{j}.theta);
            duc{j,i} = reshape(duc{j,i}, [1, 2]); % different with respect to idiosyncratic risk
        else
            duc{param.num_theta,i} = duc{param.num_theta - 1,i};
        end
    end
end

%% UPDATE DS-WEIGHTS
% omega_ind is z-dependent, omega_dyn and omega_sto aren't 
tmp = omega_ind; clear omega_ind;
omega_ind = cell(param.num_theta, param.num_phi, param.num_indiv);

for i = 1:param.num_phi
    for j = 1:param.num_theta
        for k = 1:param.num_indiv
            for z = 1:2
                omega_ind{j,i,k}(z) = tmp{z,j,i,k}(z);
            end
            omega_ind{j,i,k} = omega_ind{j,i,k}';
        end
    end
end

%% AGGREGATE ADDITIVE DECOMPOSITION

[vec_AE, vec_RS, vec_IS, vec_RE] = deal(cell(param.num_agg));
for z = 1:param.num_agg
    if z == 1, G.g = [1, 0]; else, G.g = [0, 1]; end
    
    [AE, RS, IS, RE] = deal(cell(param.num_theta, param.num_phi));

    g = reshape(G.g, [1, 2]); % different with respect to idiosyncratic risk

    for i=1:param.num_phi
        for j = 1:param.num_theta

            % Aggregate efficiency:
            AE{j,i} = 0; 
            for n = 1:param.N
                AE{j,i} = AE{j,i} + (omega_dyn{j,i,1}(:, n)' * (g' * .5) + ...
                                         omega_dyn{j,i,2}(:, n)' * (g' * .5)) ...
                                  * (sum(sum( omega_sto_norm{j,i,1}{n} .* (P{n} .* g * .5) )) + ...
                                         sum(sum( omega_sto_norm{j,i,2}{n} .* (P{n} .* g * .5) ))) ...
                                  * (sum(sum( duc{j,1}' .* (P{n} .* g * .5) )) + ....
                                         sum(sum( duc{j,2}' .* (P{n} .* g * .5) )));
            end
            AE{j,i} = (omega_ind{j,i,1}' * (g' * .5) + omega_ind{j,i,2}' * (g' * .5)) * AE{j,i};

            % Risk-sharing:
            RS{j,i} = 0;
            for n = 1:param.N
                RS{j,i} = RS{j,i} + (omega_dyn{j,i,1}(:, n)' * (g' * .5) + omega_dyn{j,i,2}(:, n)' * (g' * .5)) ...
                                  * (sum(sum( (omega_sto_norm{j,i,1}{n} .* duc{j,1}') .* (P{n} .* g * .5) )) ...
                                   + sum(sum( (omega_sto_norm{j,i,2}{n} .* duc{j,2}') .* (P{n} .* g * .5) )));
            end
            RS{j,i} = (omega_ind{j,i,1}' * (g' * .5) + omega_ind{j,i,2}' * (g' * .5) ) * RS{j,i} - AE{j,i};

            % Intertemporal-sharing:
            IS{j,i} = 0;
            for n = 1:param.N
                IS{j,i} = IS{j,i} + (sum(sum( omega_dyn{j,i,1}(:, n)' .* ...
                                        (omega_sto_norm{j,i,1}{n} .* duc{j,1}') .* (P{n} .* g * .5) )) ...
                                  +  sum(sum( omega_dyn{j,i,2}(:, n)' .* ...
                                        (omega_sto_norm{j,i,2}{n} .* duc{j,2}') .* (P{n} .* g * .5) )));
            end
            IS{j,i} = (omega_ind{j,i,1}' * (g' * .5) + omega_ind{j,i,2}' * (g' * .5)) * IS{j,i} - (RS{j,i} + AE{j,i});

            % Redistribution: 
            tmp = zeros(2,1);
            for k = 1:param.num_indiv
                temp = zeros(2, 2);
                for n = 1:param.N
                    temp = temp + omega_dyn{j,i,k}(:, n)' .* ...
                                     (omega_sto_norm{j,i,k}{n} .* duc{j,k}') .* (P{n} .* g * .5);
                end
                tmp(k) = sum(sum(omega_ind{j,i,k}' .* temp));
            end
            RE{j,i} = (tmp(1) + tmp(2)) - (IS{j,i} + RS{j,i} + AE{j,i});
        end
    end

    % save results in vectors to plot them later
    for i = 1:param.num_phi
        for j = 1:param.num_theta
            vec_AE{z}(j,i)  = AE{j,i};
            vec_RS{z}(j,i)  = RS{j,i};
            vec_IS{z}(j,i)  = IS{j,i};
            vec_RE{z}(j,i)  = RE{j,i};
        end
    end
end

%% OUTPUT
run_time = toc(run_time); fprintf('\n\nAlgorithm converged. Run-time of: %.2f seconds.\n', run_time);

fprintf('\nPlotting Figures...\n');

run_figures;

diary off

