function [AE, RS, IS, RE, norm_factor] = additive_decomp(G, ss, param)

% Pre-allocation
[AE, RS, IS, RE, norm_factor] = deal(cell(param.num_theta, 1));
g = reshape(G.g, [param.discrete_types * G.J, 1]);

for j = 1:param.num_theta
    
    fprintf('     ... computing for θ = %.2f\n', G.theta(j));
    
    P_old   = speye(2*G.J);
    P_old_j = speye(2*G.J);

    [omega_ind, omega_dyn, norm_factor{j}] = DS_weights('ind_dyn', j, G, [], ss, param);
    [AE{j}, RS{j}, IS{j}, RE{j}] = deal(0);
    
    for n = 1:param.N
        
        if j < param.num_theta
            % solve transitory density
            P   = density(j, n, P_old, ss, G, param);
            P_j = density(j+1, n, P_old_j, ss, G, param);

            % effects
            dc = (param.u(ss{j+1}.c(:)) - param.u(ss{j}.c(:))) ./ param.u1(ss{j}.c(:)) ./ param.dtheta;
            dp = (P_j - P) ./ max(1e-16, P) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j+1}.c(:)) ./ param.u1(ss{j}.c(:)))';
            
        else
            % solve transitory density
            P   = density(j, n, P_old, ss, G, param);
            P_j = density(j-1, n, P_old_j, ss, G, param);

            % effects
            dc = (param.u(ss{j}.c(:)) - param.u(ss{j-1}.c(:))) ./ param.u1(ss{j-1}.c(:)) ./ param.dtheta;
            dp = (P - P_j) ./ max(1e-16, P_j) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j}.c(:)) ./ param.u1(ss{j-1}.c(:)))';
        end
        
        % stochastic DS-weights
        omega_sto  = DS_weights('sto', j, [], P, ss, param);
    
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