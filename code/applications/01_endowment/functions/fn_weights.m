function [omega,omega_i,omega_t_i,omega_t_i_ref,omega_s_i] = fn_weights(V,u_prime,Pi,beta,a,phi,I,S,T)

[omega_t_i, omega_t_i_ref] = deal(zeros(S,T,I));
[omega_s_i, omega]       = deal(zeros(S,S,T,I));

%% Auxiliary Computations

% partialW/partialV
partial_W_partial_V                           = fn_partial_W_partial_V(V,a,phi);

% Permanent Consumption
lambda                                        = fn_lambda(u_prime,beta,Pi,S);

% Shadow Prices
[q_state_price, q_zero_coupon, q_consol_bond] = fn_shadow_prices(u_prime,lambda,Pi,beta,I,S,T);


%% DS-Weights: Individual Multiplicative Decomposition

% Individual DS-Weights
omega_i                    = [(partial_W_partial_V(1,1)*lambda(1,1))/mean(partial_W_partial_V(1,:).*lambda(1,:)),...
                              (partial_W_partial_V(1,2)*lambda(1,2))/mean(partial_W_partial_V(1,:).*lambda(1,:));  % s0 = L
                              (partial_W_partial_V(2,1)*lambda(2,1))/mean(partial_W_partial_V(2,:).*lambda(2,:)),...
                              (partial_W_partial_V(2,2)*lambda(2,2))/mean(partial_W_partial_V(2,:).*lambda(2,:))]; % s0 = H

% Dynamic Weights
for i = 1:I
    omega_t_i(:,:,i)         = q_zero_coupon(:,:,i)./q_consol_bond(:,i);
    parfor t = 1:T
        omega_t_i_ref(:,t,i) = beta(i)^(t-1)*(1-beta(i));
    end
end

% Stochastic Weights
for i = 1:I
    parfor t = 1:T
        omega_s_i(:,:,t,i)   = q_state_price(:,:,i)^(t-1)./q_zero_coupon(:,t,i);
    end
end

% DS-Weights
for i = 1:I
    parfor t = 1:T
        omega(:,:,t,i)     = omega_i(:,i).*omega_s_i(:,:,t,i).*omega_t_i(:,t,i);
    end
end



end



