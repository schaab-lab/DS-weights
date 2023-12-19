fprintf('Persistence Grid: Policy Grid START\n')

% Initializing variables
[dW_rho_theta,Xi_AE_rho_theta,Xi_RD_rho_theta,Xi_RS_rho_theta,Xi_IS_rho_theta]                     = deal(zeros(param.S,length(rho_grid)));

%% Grid theta
theta_grid = (0:0.1:1)';

[dW_rho_theta_tmp,Xi_AE_rho_theta_tmp,Xi_RD_rho_theta_tmp,Xi_RS_rho_theta_tmp,Xi_IS_rho_theta_tmp] = deal(zeros(param.S,length(theta_grid)));

for i = 1:length(rho_grid)
    parfor j = 1:length(theta_grid)

        theta = theta_grid(j);
        rho   = rho_grid(i);

        % Transition matrix
        Pi                                      = [rho_grid(i), 1-rho_grid(i); 1-rho_grid(i), rho_grid(i)];

        % Equilibrium Values for each theta given rho
        [c, V, u_prime]                         = fn_solution(param.y,theta,param.Ts,param.beta,param.gamma,Pi,param.S);
        
        % Individual Multiplicative Decomposition for each theta given rho
        [~,omega_i,omega_t_i,~,omega_s_i]       = fn_weights(V,u_prime,Pi,param.beta,param.planner_a,param.planner_phi,param.I,param.S,param.T);
        
        % dV|lambda
        [dV_lambda, dV_lambda_t, dV_lambda_t_s] = fn_dV(omega_s_i,omega_t_i,param.Ts,param.S,param.T,param.I);
        
        % Aggregate Additive Decomposition for each theta given rho
        [dW_rho_theta_tmp(:,j),Xi_AE_rho_theta_tmp(:,j),Xi_RD_rho_theta_tmp(:,j),Xi_RS_rho_theta_tmp(:,j),Xi_IS_rho_theta_tmp(:,j)] = fn_welfare_decomp(omega_i,omega_s_i,omega_t_i,dV_lambda_t,dV_lambda_t_s,param.S,param.T,param.I);
    end

    % Integrating over theta
    parfor s = 1:param.S
        dW_rho_theta(s,i)    = trapz(theta_grid,dW_rho_theta_tmp(s,:));
        Xi_AE_rho_theta(s,i) = trapz(theta_grid,Xi_AE_rho_theta_tmp(s,:));
        Xi_RD_rho_theta(s,i) = trapz(theta_grid,Xi_RD_rho_theta_tmp(s,:));
        Xi_RS_rho_theta(s,i) = trapz(theta_grid,Xi_RS_rho_theta_tmp(s,:));
        Xi_IS_rho_theta(s,i) = trapz(theta_grid,Xi_IS_rho_theta_tmp(s,:));
    end

end

%% Peak Intertemporal-Sharing
fprintf('Intertemporal-Sharing peaks at rho = %3.4f\n',rho_grid(find(Xi_IS_rho_theta(1,:)==max(Xi_IS_rho_theta(1,:)))))

fprintf('Persistence Grid: Fixed Policy (theta=0) DONE\n\n')
