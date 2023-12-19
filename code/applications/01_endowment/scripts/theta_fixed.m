fprintf('Fixed Policy (theta = %3.2f) START \n',param.theta)

%% Equilibrium

[c, V, u_prime] = fn_solution(param.y,param.theta,param.Ts,param.beta,param.gamma,param.Pi,param.S);

%% Welfare Assessment

% Weights
[omega,omega_i,omega_t_i,omega_t_i_ref,omega_s_i] = fn_weights(V,u_prime,param.Pi,param.beta,param.planner_a,param.planner_phi,param.I,param.S,param.T);

% Welfare gains
[dV_lambda, dV_lambda_t, dV_lambda_t_s] = fn_dV(omega_s_i,omega_t_i,param.Ts,param.S,param.T,param.I);

% Welfare decomposition
[dW,Xi_AE,Xi_RD,Xi_RS,Xi_IS,TS] = fn_welfare_decomp(omega_i,omega_s_i,omega_t_i,dV_lambda_t,dV_lambda_t_s,param.S,param.T,param.I);

%% Figures

fig_app1_fixed(omega,omega_i,omega_t_i,omega_s_i,omega_t_i_ref,param.T_fig,param.rho,optfig)
fig_term_structure(TS,dV_lambda_t,omega_t_i,param.T_fig,param.rho,optfig)

fprintf('Fixed Policy (theta = %3.2f) DONE \n\n',param.theta)
