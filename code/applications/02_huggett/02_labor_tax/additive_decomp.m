function [AE, RS, IS, RE] = additive_decomp(G, sim, ss, param)

%% TRANSITION WELFARE EFFECTS

% Pre-allocation
[AE, RS, IS, RE] = deal(cell(param.num_theta, 1));
g = reshape(G.g, [param.discrete_types * G.J, 1]);

for j = 1:param.num_theta
    
    fprintf('     ... computing for θ = %.2f (transition)\n', G.theta(j));
    
    P_old   = speye(2*G.J);
    P_old_j = speye(2*G.J);

    [omega_ind, omega_dyn] = DS_weights('ind_dyn', j, [], G, [], sim, param);
    [AE{j}, RS{j}, IS{j}, RE{j}] = deal(0);
    
    for n = 1:param.N
        
        if j < param.num_theta
            % solve transitory density
            P   = density(n, P_old, sim{j}.A{n}, G, param);
            P_j = density(n, P_old_j, sim{j+1}.A{n}, G, param);

            % effects
            dc = (param.u(sim{j+1}.c{n}(:)) - param.u(sim{j}.c{n}(:))) ...
                ./ param.u1(sim{j}.c{n}(:)) ./ param.dtheta;
            dp = (P_j - P) ./ max(1e-16, P) ./ param.dtheta;
            dp_effect = dp' .* (param.u(sim{j+1}.c{n}(:)) ./ param.u1(sim{j}.c{n}(:)))';
            
        else
            % solve transitory density
            P   = density(n, P_old, sim{j}.A{n}, G, param);
            P_j = density(n, P_old_j, sim{j-1}.A{n}, G, param);

            % effects
            dc = (param.u(sim{j}.c{n}(:)) - param.u(sim{j-1}.c{n}(:))) ...
                ./ param.u1(sim{j-1}.c{n}(:)) ./ param.dtheta;
            dp = (P - P_j) ./ max(1e-16, P_j) ./ param.dtheta;
            dp_effect = dp' .* (param.u(sim{j}.c{n}(:)) ./ param.u1(sim{j-1}.c{n}(:)))';
        end
        
        % stochastic DS-weights
        omega_sto  = DS_weights('sto', j, n, [], P, sim, param);
    
        % aggregate efficiency term
        AE{j} = AE{j} + (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(omega_sto * g) * sum(sum( (dp_effect + dc') .* (P' .* g) ));

        % risk-sharing term
        RS{j} = RS{j} + (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(sum( omega_sto' .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(omega_sto * g) * sum(sum( (dp_effect + dc') .* (P' .* g) ));


        % inter-temporal sharing term
        IS{j} = IS{j} + (omega_ind' * g) * sum(sum( (omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(sum( omega_sto' .* (dp_effect + dc') .* g ));

        % redistribution term
        RE{j} = RE{j} + sum(sum( (omega_ind .* omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * sum(sum( (omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g ));
                  
       % update old transition density
       P_old = P; P_old_j = P_j;    
            
    end
    
    % save last transition density
    ss{j}.P = P;
   
end

% add steady-state welfare effects
[AE_ss, RS_ss, IS_ss, RE_ss] = additive_decomp_ss(G, ss, param);
for j = 1:param.num_theta
    
    AE{j} = AE{j} + exp(param.rho * param.T) * AE_ss{j};
    RS{j} = RS{j} + exp(param.rho * param.T) * RS_ss{j};
    IS{j} = IS{j} + exp(param.rho * param.T) * IS_ss{j};
    RE{j} = RE{j} + exp(param.rho * param.T) * RE_ss{j};
    
end

end

%% STEADY-STATE WELFARE EFFECTS

function [AE, RS, IS, RE] = additive_decomp_ss(G, ss, param)

% Increase last time period
param = define_parameters('N', param.ss_N, 'T', param.ss_T);

% Pre-allocation
[AE, RS, IS, RE, norm_factor] = deal(cell(param.num_theta, 1));
g = reshape(G.g, [param.discrete_types * G.J, 1]);

for j = 1:param.num_theta
    
    fprintf('     ... computing for θ = %.2f (steady-state)\n', G.theta(j));
    
    P_old   = ss{j}.P;
    if j < param.num_theta, P_old_j = ss{j+1}.P; else, P_old_j = ss{j-1}.P; end

    [omega_ind, omega_dyn] = DS_weights('ss_ind_dyn', j, [], G, [], ss, param);
    [AE{j}, RS{j}, IS{j}, RE{j}] = deal(0);
    
    for n = 1:param.N
        
        if j < param.num_theta
            % solve transitory density
            P   = density([], P_old, ss{j}.A, G, param);
            P_j = density([], P_old_j, ss{j+1}.A, G, param);

            % effects
            dc = (param.u(ss{j+1}.c(:)) - param.u(ss{j}.c(:))) ./ param.u1(ss{j}.c(:)) ./ param.dtheta;
            dp = (P_j - P) ./ max(1e-16, P) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j+1}.c(:)) ./ param.u1(ss{j}.c(:)))';
            
        else
            % solve transitory density
            P   = density([], P_old, ss{j}.A, G, param);
            P_j = density([], P_old_j, ss{j-1}.A, G, param);

            % effects
            dc = (param.u(ss{j}.c(:)) - param.u(ss{j-1}.c(:))) ./ param.u1(ss{j-1}.c(:)) ./ param.dtheta;
            dp = (P - P_j) ./ max(1e-16, P_j) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j}.c(:)) ./ param.u1(ss{j-1}.c(:)))';
        end
        
        % stochastic DS-weights
        omega_sto  = DS_weights('ss_sto', j, n, [], P, ss, param);
    
        % aggregate efficiency term
        AE{j} = AE{j} + (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(omega_sto * g) * sum(sum( (dp_effect + dc') .* (P' .* g) ));

        % risk-sharing term
        RS{j} = RS{j} + (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(sum( omega_sto' .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(omega_sto * g) * sum(sum( (dp_effect + dc') .* (P' .* g) ));


        % inter-temporal sharing term
        IS{j} = IS{j} + (omega_ind' * g) * sum(sum( (omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * (omega_dyn(:, n)' * g) ...
                      * sum(sum( omega_sto' .* (dp_effect + dc') .* g ));

        % redistribution term
        RE{j} = RE{j} + sum(sum( (omega_ind .* omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g )) ...
                      - (omega_ind' * g) * sum(sum( (omega_dyn(:, n) ...
                      .* omega_sto') .* (dp_effect + dc') .* g ));
                  
       % update old transition density
       P_old = P; P_old_j = P_j;    
            
    end
    
end

end