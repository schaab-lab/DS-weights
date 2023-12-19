function dV_dtau = fn_dV_dtau_det(w,c,n,tau,alpha,sigma,gamma)

% Auxiliary Computations
lambda  = fn_lambda_det(c,n,alpha,sigma,gamma);

E       = fn_E(w,n);
dE_dtau = fn_dE_dtau(w,n,sigma,alpha);

dg      = (1/length(w))*(E + tau*dE_dtau);

% dV/dtau
dV_dtau = lambda.*(-w.*n + dg);

end