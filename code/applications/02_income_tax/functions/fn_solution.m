function [c_opt,n_opt,g_opt,V_opt] = fn_solution(tau,w,alpha,sigma,gamma)

% Optimal Labor Supply
n_opt = fn_n_opt(w,tau,alpha,sigma);

% Optimal Uniform per-capita Grant
g_opt = fn_g(w,n_opt,tau);

% Optimal Consumption
c_opt = fn_c(w,tau,n_opt,g_opt);

% Indirect Utility Function
V_opt = fn_V(c_opt,n_opt,alpha,sigma,gamma);

end