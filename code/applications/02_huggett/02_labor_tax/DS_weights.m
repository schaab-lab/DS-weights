function [omega_1, omega_2, norm_factor] = DS_weights(type, j, n, G, P, sim, param)

% This function return either the individual and dynamic DS-weights 
% (as well as the normalization factor used) or the stochastic DS-weights.
%
% Syntax is:
%    * [omega_ind, omega_dyn] = DS_weights('ind_dyn', j, [], G, [], sim, param)
%    
%    * omega_sto = DS_weights('sto', j, n, [], P, sim, param);
%

switch type
    
    case 'ind_dyn'
        %% COMPUTE INDIVIDUAL AND DYNAMIC DS-WEIGHTS (for normalized utilitarian)
        
        % Modified discount factor: 
        beta = param.dt .* exp(-param.rho * param.t);

        % Pareto weights:
        alpha = ones(param.discrete_types * G.J, 1);

        % Note: we want allocation objects to be column vectors now

        P_old = speye(2*G.J);

        % Compute components:

        % Weighted marginal utilities:
        weighted_u1 = zeros(param.discrete_types * G.J, param.N);
        for n = 1:param.N
            P = density(j, n, P_old, sim, G, param);
            weighted_u1(:, n) = beta(n) * P' * param.u1(sim{j}.c{n}(:));
            P_old = P;
        end

        % Individual component:
        omega_ind = alpha .* sum(weighted_u1, 2) ./ ...
                       (G.g' * (alpha .* sum(weighted_u1, 2)));

        % Dynamic component:
        omega_dyn = zeros(param.discrete_types * G.J, param.N);
        div = sum(weighted_u1, 2);
        for n = 1:param.N
            omega_dyn(:, n) = weighted_u1(:, n) ./ div;
        end

        % Return results
        omega_1 = omega_ind;
        omega_2 = omega_dyn;
        norm_factor = (G.g' * (alpha .* sum(weighted_u1, 2)));
    
    case 'sto'
        %% COMPUTE DS-WEIGHTS STOCHASTIC (for normalized utilitarian)
 
        % Compute components:
        omega_sto = P .* param.u1(sim{j}.c{n}(:)) ./ (P' * param.u1(sim{j}.c{n}(:)) )';
        omega_sto_norm = param.u1(sim{j}.c{n}(:))' ./ sum(param.u1(sim{j}.c{n}(:))' .* P, 2);
        
        % Return results
        omega_1 = omega_sto;
        omega_2 = omega_sto_norm;
        norm_factor = [];
        
    otherwise
        error('The first input "type" has to be either "ind_dyn" or "sto".')
        
end
    
end