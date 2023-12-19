function [c, V, u_prime] = fn_solution(y,theta,Ts,beta,gamma,Pi,S)

% Optimal Consumption
c           = fn_c(y,theta,Ts);

% Utility
u           = fn_u(c,gamma);

% Marginal Utility
u_prime     = fn_u_prime(c, gamma);

% Indirect Utility
V           = (eye(S)-beta.*Pi)\u;

end