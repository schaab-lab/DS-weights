
[dW_analytical_det,dW_analytical_rand] = deal(zeros(length(tau_grid),1));

%% Deterministic Earnings

% dV\dtau
dV_numerical_det  = [gradient(V_opt_det(:,1),tau_grid), gradient(V_opt_det(:,2),tau_grid)];

% V
V_numerical_det   = [fn_integral_X(V_opt_det(:,1),dV_det(:,1),tau_grid,tau_spc),...
                     fn_integral_X(V_opt_det(:,2),dV_det(:,2),tau_grid,tau_spc)];

% W
parfor i = 1:length(tau_grid)
    dW_analytical_det(i) = sum(dV_det(i,:));
end
dW_numerical_det  = gradient(W_det,tau_grid);
W_numerical_det   = [fn_integral_X(W_det,dW_analytical_det,tau_grid,tau_spc)];

%% Random Earnings

% dV\dtau
dV_numerical_rand  = [gradient(V_opt_rand(:,1),tau_grid), gradient(V_opt_rand(:,2),tau_grid)];

% V
V_numerical_rand   = [fn_integral_X(V_opt_rand(:,1),dV_rand(:,1),tau_grid,tau_spc),...
                      fn_integral_X(V_opt_rand(:,2),dV_rand(:,2),tau_grid,tau_spc)];

% W
parfor i = 1:length(tau_grid)
    dW_analytical_rand(i) = sum(dV_rand(i,:));
end
dW_numerical_rand  = gradient(W_rand,tau_grid);
W_numerical_rand   = [fn_integral_X(W_rand,dW_analytical_rand,tau_grid,tau_spc)];

%% Figures
fig_numerical_test(tau_grid,W_det,W_rand,W_numerical_det,W_numerical_rand,dW_analytical_det,dW_analytical_rand,dW_numerical_det,dW_numerical_rand,...
    V_opt_det,V_numerical_det,V_opt_rand,V_numerical_rand,dV_det,dV_numerical_det,dV_rand,dV_numerical_rand,optfig)


