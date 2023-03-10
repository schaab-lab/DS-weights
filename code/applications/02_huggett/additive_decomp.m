function [AE, RS, IS, RE, norm_factor] = additive_decomp(P, G, ss, param)

% get DS-weights
fprintf('     ... computing DS-weights\n\n');
[omega_ind, omega_dyn, omega_sto, ~, norm_factor] = DS_weights(P, G, ss, param);

% pre-allocation
[AE, RS, IS, RE] = deal(cell(param.num_theta, 1));
g = reshape(G.g, [param.discrete_types * G.J, 1]);

for j = 1:param.num_theta
    
    fprintf('     ... computing for θ = %.2f\n', G.theta(j));
    
    [AE{j}, RS{j}, IS{j}, RE{j}] = deal(0);
    for n = 1:param.N
        
        % effects
        if j < param.num_theta
            dc = (ss{j+1}.c(:) - ss{j}.c(:)) ./ param.dtheta; 
            
            dp = (P{j+1}{n} - P{j}{n}) ./ max(1e-16, P{j}{n}) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j+1}.c(:)) ./ param.u1(ss{j}.c(:)))';
        else
            dp = (P{j}{n} - P{j-1}{n}) ./ max(1e-16, P{j-1}{n}) ./ param.dtheta;
            dp_effect = dp' .* (param.u(ss{j}.c(:)) ./ param.u1(ss{j-1}.c(:)))';
        end
    
        % aggregate efficiency term
        AE{j} = AE{j} + (omega_ind{j}' * g) * (omega_dyn{j}(:, n)' * g) ...
                      * sum(omega_sto{j}{n} * g) * sum(sum( (dp_effect + dc') .* (P{j}{n}' .* g) ));

        % risk-sharing term
        RS{j} = RS{j} + (omega_ind{j}' * g) * (omega_dyn{j}(:, n)' * g) ...
                      * sum(sum( omega_sto{j}{n}' .* (dp_effect + dc') .* g )) ...
                      - (omega_ind{j}' * g) * (omega_dyn{j}(:, n)' * g) ...
                      * sum(omega_sto{j}{n} * g) * sum(sum( (dp_effect + dc') .* (P{j}{n}' .* g) ));


        % inter-temporal sharing term
        IS{j} = IS{j} + (omega_ind{j}' * g) * sum(sum( (omega_dyn{j}(:, n) ...
                      .* omega_sto{j}{n}') .* (dp_effect + dc') .* g )) ...
                      - (omega_ind{j}' * g) * (omega_dyn{j}(:, n)' * g) ...
                      * sum(sum( omega_sto{j}{n}' .* (dp_effect + dc') .* g ));

        % redistribution term
        RE{j} = RE{j} + sum(sum( omega_ind{j} .* omega_dyn{j}(:, n) ...
                      .* omega_sto{j}{n}' .* (dp_effect + dc') .* g )) ...
                      - (omega_ind{j}' * g) * sum(sum( (omega_dyn{j}(:, n) ...
                      .* omega_sto{j}{n}') .* (dp_effect + dc') .* g ));
            
    end

end

end