function [omega_i, omega_s_L_i, omega_s_H_i] = fn_weights_rand(c_L,c_H,n_L,n_H,pi,alpha,sigma,gamma)

u_prime_c_L  = fn_u_prime_c(c_L,n_L,alpha,sigma,gamma);
u_prime_c_H  = fn_u_prime_c(c_H,n_H,alpha,sigma,gamma);
lambda       = fn_lambda_rand(c_L,c_H,n_L,n_H,pi,alpha,sigma,gamma);

% Individual Weights
omega_i      = lambda./mean(lambda);

% Stochastic Weights
omega_s_L_i  = (pi(1).*u_prime_c_L)./lambda;
omega_s_H_i  = (pi(2).*u_prime_c_H)./lambda;

end