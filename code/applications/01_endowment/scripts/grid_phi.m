fprintf('SWF Grid START \n\n')

phi_grid = [1, 5, 10];

% Initializing variables
[c_phi, V_phi, u_prime_phi, dV_lambda_phi,dV_lambda_t_s_phi,omega_i_phi] = deal(zeros(param.S,param.I,length(param.theta_grid),length(phi_grid)));
[dW_phi,Xi_AE_phi,Xi_RD_phi,Xi_RS_phi,Xi_IS_phi]                         = deal(zeros(param.S,length(param.theta_grid),length(phi_grid)));
dV_lambda_t_phi                                                          = deal(zeros(param.S,param.T,param.I,length(param.theta_grid),length(phi_grid)));

%% Equilibrium on the grid

for i = 1:length(phi_grid)
    parfor j = 1:length(param.theta_grid)
        
        theta                = param.theta_grid(j);
        [c, V, u_prime]      = fn_solution(param.y,theta,param.Ts,param.beta,param.gamma,param.Pi,param.S);
        
        % Optimal Consumption
        c_phi(:,:,j,i)       = c;
        
        % Indirect Utility
        V_phi(:,:,j,i)       = V;
        
        % Marginal Utility
        u_prime_phi(:,:,j,i) = u_prime;
    end
end

%% Welfare Assessment

for i = 1:length(phi_grid)
    parfor j = 1:length(param.theta_grid)
        
        phi = phi_grid(i);
        
        % Individual Multiplicative Decomposition
        [~,omega_i_phi(:,:,j,i),omega_t_i,~,omega_s_i] = fn_weights(squeeze(V_phi(:,:,j,i)),squeeze(u_prime_phi(:,:,j,i)),param.Pi,param.beta,param.planner_a,phi,param.I,param.S,param.T);
        
        % dV|lambda
        [dV_lambda_phi(:,:,j,i), dV_lambda_t_phi(:,:,:,j,i), dV_lambda_t_s_phi(:,:,j,i)]    = fn_dV(omega_s_i,omega_t_i,param.Ts,param.S,param.T,param.I);
        
        % Aggregate Additive Decomposition
        [dW_phi(:,j,i),Xi_AE_phi(:,j,i),Xi_RD_phi(:,j,i),Xi_RS_phi(:,j,i),Xi_IS_phi(:,j,i)] = fn_welfare_decomp(omega_i_phi(:,:,j,i),omega_s_i,omega_t_i,dV_lambda_t_phi(:,:,:,j,i),dV_lambda_t_s_phi(:,:,j,i),param.S,param.T,param.I);
    end
end

fprintf('SWF Grid DONE \n\n')

%% Figures

fig_app1_phi(phi_grid,param.theta_grid,dW_phi,Xi_RS_phi,Xi_IS_phi,Xi_RD_phi,omega_i_phi,param.rho,optfig)
