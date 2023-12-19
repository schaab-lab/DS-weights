function [omega_i,omega_s_L_i,omega_s_H_i,omega_0_i,omega_1_i] = fn_weights(b,k0,q0,n0,n1,z,pi,gamma,phi,beta)

% Marginal Utilities
u_prime_1 = fn_u_prime(b(1),k0,q0,n0(1),n1(1,:),z,gamma(1),phi);
u_prime_2 = fn_u_prime(b(2),0,q0,n0(2),n1(2,:),z,gamma(2),phi);

% Lambda
lambda    = [fn_lambda(b(1),k0,q0,n0(1),n1(1,:),z,pi,gamma(1),phi,beta(1));
             fn_lambda(b(2),0,q0,n0(2),n1(2,:),z,pi,gamma(2),phi,beta(2))];

% Individual Weights
omega_i   = [lambda(1)/mean(lambda), lambda(2)/mean(lambda)];

% Stochastic Weights
denom_1   = pi(1)*u_prime_1(2) + pi(2)*u_prime_1(3);
denom_2   = pi(1)*u_prime_2(2) + pi(2)*u_prime_2(3);

omega_s_L_i = [(pi(1)*u_prime_1(2))/denom_1, (pi(1)*u_prime_2(2))/denom_2];
omega_s_H_i = [(pi(2)*u_prime_1(3))/denom_1, (pi(2)*u_prime_2(3))/denom_2];

% Dynamic Weights
omega_0_i   = [u_prime_1(1)/lambda(1); u_prime_2(1)/lambda(2)];
omega_1_i   = [(beta(1)*denom_1)/lambda(1); (beta(2)*denom_2)/lambda(2)];

end


