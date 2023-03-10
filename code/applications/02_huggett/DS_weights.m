function [omega_ind, omega_dyn, omega_sto, omega_sto_norm, norm_factor] = DS_weights(P, G, ss, param)

% Modified discount factor: 
beta = param.dt * exp(-param.rho * param.t);

% Initialize data structure:
omega_ind = cell(param.num_theta, 1);
omega_dyn = cell(param.num_theta, 1);
omega_sto = cell(param.num_theta, 1);
omega_sto_norm = cell(param.num_theta, 1);
norm_factor = cell(param.num_theta, 1);

% Pareto weights:
alpha = ones(param.discrete_types * G.J, 1);

% Compute components:
for j = 1:param.num_theta
        
    % Weighted marginal utilities:
    weighted_u1 = zeros(param.discrete_types * G.J, param.N);
    for n = 1:param.N
        weighted_u1(:, n) = beta(n) * P{j}{n}' * param.u1(ss{j}.c(:));
    end
    
    % Individual component:
    omega_ind{j} = alpha .* sum(weighted_u1, 2) ./ ...
                   (G.g' * (alpha .* sum(weighted_u1, 2)));
               
    % normalization
    norm_factor{j} = G.g' * (alpha .* sum(weighted_u1, 2));
    
    % Dynamic component:
    omega_dyn{j} = zeros(param.discrete_types * G.J, param.N);
    for n = 1:param.N
        omega_dyn{j}(:, n) = weighted_u1(:, n) ./ sum(weighted_u1, 2);
    end

    % Stochastic component:
    for n = 1:param.N
        omega_sto{j}{n} = P{j}{n} .* (param.u1(ss{j}.c(:))) ./ (P{j}{n}' * (param.u1(ss{j}.c(:))))';
        omega_sto_norm{j}{n} = param.u1(ss{j}.c(:))' ./ sum(param.u1(ss{j}.c(:))' .* P{j}{n}, 2);
    end
    
end

end