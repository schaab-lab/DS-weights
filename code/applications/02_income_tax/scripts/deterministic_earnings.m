fprintf('Welfare Decomposition: Deterministic case START\n')

[c_opt_det,n_opt_det,g_opt_det,V_opt_det,omega_i_det,dV_det,dV_lambda_det] = deal(zeros(length(tau_grid),2));
[Xi_AE_det, Xi_RD_det, Xi_RS_det, dW_det, W_det, C_det, N_det]             = deal(zeros(length(tau_grid),1));


%% Optimal Solution on the grid
parfor i = 1:length(tau_grid)
    tau = tau_grid(i);

    % Equilibrium Values
    [c_opt_det(i,:),n_opt_det(i,:),g_opt_det(i),V_opt_det(i,:)] = fn_solution(tau,wages_det,alpha,sigma,gamma);

end


%% Aggregates
parfor i = 1:length(tau_grid)

    % Welfare
    W_det(i) = sum(V_opt_det(i,:));

    % Consumption
    C_det(i) = sum(c_opt_det(i,:));

    % Labor
    N_det(i) = sum(n_opt_det(i,:));

end

%% Welfare Assessment
parfor i = 1:length(tau_grid)

    tau = tau_grid(i);

    % DS-Weights
    [omega_i_det(i,:)] = fn_weights_det(c_opt_det(i,:),n_opt_det(i,:),alpha,sigma,gamma);
    
    % dV/dtau
    dV_det(i,:)        = fn_dV_dtau_det(wages_det,c_opt_det(i,:),n_opt_det(i,:),tau,alpha,sigma,gamma);

    % dV/dtau/lambda
    dV_lambda_det(i,:) = fn_dV_dtau_lambda_det(wages_det,c_opt_det(i,:),n_opt_det(i,:),tau,alpha,sigma,gamma);

    % Aggregate Additive Welfare Decomposition
    [Xi_AE_det(i),Xi_RD_det(i),Xi_RS_det(i),dW_det(i)] = fn_welfare_decomp_det(wages_det,n_opt_det(i,:),omega_i_det(i,:),dV_lambda_det(i,:),tau,sigma,alpha);

end


%% Optimal Tax
f_opt_det   = @(x) interp1(tau_grid,dW_det,x);
tau_opt_det = broyden(f_opt_det,mean(tau_grid));
fprintf('Optimal tax rate in the Deterministic case is %6.4f \n',tau_opt_det)

fig_eq_det(tau_grid,tau_opt_det,c_opt_det,n_opt_det,V_opt_det,optfig)
fig_weights_det(tau_grid,tau_opt_det,omega_i_det,optfig)


fprintf('Welfare Decomposition: Deterministic case DONE \n\n')

