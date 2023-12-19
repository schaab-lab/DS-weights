function [Xi_AE, Xi_RD, Xi_RS, dW] = fn_welfare_decomp_rand(w_L,w_H,n_L,n_H,omega_i,omega_s_L_i,omega_s_H_i,dV_lambda,tau,sigma,alpha)

dE_dtau_L   = fn_dE_dtau(w_L,n_L,sigma,alpha);
dE_dtau_H   = fn_dE_dtau(w_H,n_H,sigma,alpha);

dg_L        = (1/length(w_L))*(fn_E(w_L,n_L) + tau.*dE_dtau_L);
dg_H        = (1/length(w_H))*(fn_E(w_H,n_H) + tau.*dE_dtau_H);

omega_s_L   = mean(omega_s_L_i);
omega_s_H   = mean(omega_s_H_i);

% Aggregate Efficiency
Xi_AE = tau*(omega_s_L.*dE_dtau_L + omega_s_H.*dE_dtau_H);

% Redistribution
Xi_RD = fn_covar(omega_i,dV_lambda,2);

% Risk-Sharing
tmp_L = dg_L - w_L.*n_L;
tmp_H = dg_H - w_H.*n_H;
Xi_RS = omega_s_L*fn_covar(omega_s_L_i./omega_s_L,tmp_L,length(w_L)) + omega_s_H*fn_covar(omega_s_H_i./omega_s_H,tmp_H,length(w_H));

% dW/dtau
dW    = Xi_AE + Xi_RD + Xi_RS;
%dW    = sum(omega_i.*dV_lambda);

end
