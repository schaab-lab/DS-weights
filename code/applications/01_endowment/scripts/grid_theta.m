fprintf('Policy Grid START \n\n')

% Initializing variables
[c_theta, V_theta, u_prime_theta, dV_lambda_theta,dV_lambda_t_s_theta] = deal(zeros(param.S,param.I,length(param.theta_grid)));
[dW_theta,Xi_AE_theta,Xi_RD_theta,Xi_RS_theta,Xi_IS_theta]             = deal(zeros(param.S,length(param.theta_grid)));
dV_lambda_t_theta                                                      = deal(zeros(param.S,param.T,param.I,length(param.theta_grid)));

%% Equilibrium on the grid

parfor j = 1:length(param.theta_grid)
    
    theta                = param.theta_grid(j);
    [c, V, u_prime]      = fn_solution(param.y,theta,param.Ts,param.beta,param.gamma,param.Pi,param.S);
    
    c_theta(:,:,j)       = c;       % Optimal Consumption
    V_theta(:,:,j)       = V;       % Indirect Utility
    u_prime_theta(:,:,j) = u_prime; % Marginal Utility
    
end

%% Welfare Assessment

parfor j = 1:length(param.theta_grid)
    
    % Individual Multiplicative Decomposition
    [omega,omega_i,omega_t_i,omega_t_i_ref,omega_s_i] = fn_weights(squeeze(V_theta(:,:,j)),squeeze(u_prime_theta(:,:,j)),param.Pi,param.beta,param.planner_a,param.planner_phi,param.I,param.S,param.T);
    
    % dV|lambda
    [dV_lambda_theta(:,:,j), dV_lambda_t_theta(:,:,:,j), dV_lambda_t_s_theta(:,:,j)]    = fn_dV(omega_s_i,omega_t_i,param.Ts,param.S,param.T,param.I);
    
    % Aggregate Additive Decomposition
    [dW_theta(:,j),Xi_AE_theta(:,j),Xi_RD_theta(:,j),Xi_RS_theta(:,j),Xi_IS_theta(:,j)] = fn_welfare_decomp(omega_i,omega_s_i,omega_t_i,dV_lambda_t_theta(:,:,:,j),dV_lambda_t_s_theta(:,:,j),param.S,param.T,param.I);
    
end

%% Figures
fig_app1_theta(param.theta_grid,dV_lambda_theta,dW_theta,...
    Xi_AE_theta,Xi_RS_theta,Xi_IS_theta,Xi_RD_theta,c_theta,param.rho,optfig)

fprintf('Policy Grid DONE \n\n')
