
fprintf('Persistence Grid: Fixed Policy (theta=0) START\n')

% Initializing variables
[dW_rho,Xi_AE_rho,Xi_RD_rho,Xi_RS_rho,Xi_IS_rho]                                                   = deal(zeros(param.S,length(rho_grid)));

%% Fixed theta (theta = 0)
parfor i = 1:length(rho_grid)

    % Transition matrix
    Pi                                      = [rho_grid(i), 1-rho_grid(i); 1-rho_grid(i), rho_grid(i)];

    % Equilibrium Values
    [c, V, u_prime]                         = fn_solution(param.y,0,param.Ts,param.beta,param.gamma,Pi,param.S);

    % Individual Multiplicative Decomposition
    [~,omega_i,omega_t_i,~,omega_s_i]       = fn_weights(V,u_prime,Pi,param.beta,param.planner_a,param.planner_phi,param.I,param.S,param.T);

    % dV|lambda
    [dV_lambda, dV_lambda_t, dV_lambda_t_s] = fn_dV(omega_s_i,omega_t_i,param.Ts,param.S,param.T,param.I);

    % Aggregate Additive Decomposition
    [dW_rho(:,i),Xi_AE_rho(:,i),Xi_RD_rho(:,i),Xi_RS_rho(:,i),Xi_IS_rho(:,i)] = fn_welfare_decomp(omega_i,omega_s_i,omega_t_i,dV_lambda_t,dV_lambda_t_s,param.S,param.T,param.I);

end

%% Peak Intertemporal-Sharing
fprintf('Intertemporal-Sharing peaks at rho = %3.4f\n',rho_grid(find(Xi_IS_rho(1,:)==max(Xi_IS_rho(1,:)))))

fprintf('Persistence Grid: Fixed Policy (theta=0) DONE\n\n')
