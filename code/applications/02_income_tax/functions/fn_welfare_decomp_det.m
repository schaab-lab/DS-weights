function [Xi_AE, Xi_RD, Xi_RS, dW] = fn_welfare_decomp_det(w,n,omega_i,dV_lambda,tau,sigma,alpha)

dE_dtau   = fn_dE_dtau(w,n,sigma,alpha);

% Aggregate Efficiency
%Xi_AE = sum(dV_lambda);
Xi_AE = tau*dE_dtau;

% Redistribution
Xi_RD = fn_covar(omega_i,dV_lambda,length(w));

% Risk-Sharing
Xi_RS = 0;

% dW/dtau
dW    = Xi_AE + Xi_RD;
%dW    = sum(omega_i.*dV_lambda);

end
