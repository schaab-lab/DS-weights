fprintf('Welfare Decomposition: Random case START\n')

[c_opt_L_rand,c_opt_H_rand,n_opt_L_rand,n_opt_H_rand,g_opt_L_rand,g_opt_H_rand,V_opt_rand,omega_i_rand,omega_s_L_i_rand,omega_s_H_i_rand,dV_rand,dV_lambda_rand] = deal(zeros(length(tau_grid),2));
[Xi_AE_rand, Xi_RD_rand, Xi_RS_rand, dW_rand, W_rand, C_rand, N_rand]                                                                                        = deal(zeros(length(tau_grid),1));


%% Optimal Solution on the grid
parfor i = 1:length(tau_grid)
    tau = tau_grid(i);

    % Equilibrium Values
    [c_opt_L_rand(i,:),n_opt_L_rand(i,:),g_opt_L_rand(i),V_L] = fn_solution(tau,wages_rand(1,:),alpha,sigma,gamma);
    [c_opt_H_rand(i,:),n_opt_H_rand(i,:),g_opt_H_rand(i),V_H] = fn_solution(tau,wages_rand(2,:),alpha,sigma,gamma);
    V_opt_rand(i,:)                                           = pi(1).*V_L + pi(2).*V_H;

end


%% Aggregates
parfor i = 1:length(tau_grid)

    % Welfare
    W_rand(i) = sum(V_opt_rand(i,:));

    % Consumption
    C_rand(i) = sum([pi(1)*c_opt_L_rand(i,1)+pi(2)*c_opt_H_rand(i,1); ...
                      pi(1)*c_opt_L_rand(i,2)+pi(2)*c_opt_H_rand(i,2)]);

    % Labor
    N_rand(i) = sum([pi(1)*n_opt_L_rand(i,1)+pi(2)*n_opt_H_rand(i,1); ...
                      pi(1)*n_opt_L_rand(i,2)+pi(2)*n_opt_H_rand(i,2)]);
end

%% Welfare Assessment
parfor i = 1:length(tau_grid)

    tau = tau_grid(i);

    % DS-Weights
    [omega_i_rand(i,:),omega_s_L_i_rand(i,:),omega_s_H_i_rand(i,:)] = fn_weights_rand(c_opt_L_rand(i,:),c_opt_H_rand(i,:),n_opt_L_rand(i,:),n_opt_H_rand(i,:),pi,alpha,sigma,gamma);

    % dV/dtau
    dV_rand(i,:)        = fn_dV_dtau_rand(wages_rand(1,:),wages_rand(2,:),c_opt_L_rand(i,:),c_opt_H_rand(i,:),n_opt_L_rand(i,:),n_opt_H_rand(i,:),omega_s_L_i_rand(i,:),omega_s_H_i_rand(i,:),tau,pi,alpha,sigma,gamma);

    % dV/dtau/lambda
    dV_lambda_rand(i,:) = fn_dV_dtau_lambda_rand(wages_rand(1,:),wages_rand(2,:),c_opt_L_rand(i,:),c_opt_H_rand(i,:),n_opt_L_rand(i,:),n_opt_H_rand(i,:),omega_s_L_i_rand(i,:),omega_s_H_i_rand(i,:),tau,pi,alpha,sigma,gamma);

    % Aggregate Additive Welfare Decomposition
    [Xi_AE_rand(i),Xi_RD_rand(i),Xi_RS_rand(i),dW_rand(i)] = fn_welfare_decomp_rand(wages_rand(1,:),wages_rand(2,:),n_opt_L_rand(i,:),n_opt_H_rand(i,:),omega_i_rand(i,:),omega_s_L_i_rand(i,:),omega_s_H_i_rand(i,:),dV_lambda_rand(i,:),tau,sigma,alpha);

end


%% Optimal Tax
f_opt_rand   = @(x) interp1(tau_grid,dW_rand,x);
tau_opt_rand = broyden(f_opt_rand,mean(tau_grid));

fprintf('Optimal tax rate in the Random case is %6.4f \n',tau_opt_rand)

fig_eq_rand(tau_grid,tau_opt_rand,c_opt_L_rand,c_opt_H_rand,n_opt_L_rand,n_opt_H_rand,V_opt_rand,optfig)
fig_weights_rand(tau_grid,tau_opt_rand,omega_i_rand,omega_s_L_i_rand,omega_s_H_i_rand,optfig)

fprintf('Welfare Decomposition: Random case DONE \n\n')

