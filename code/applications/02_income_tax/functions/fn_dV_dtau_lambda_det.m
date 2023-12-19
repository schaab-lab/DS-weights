function dV_dtau_lambda = fn_dV_dtau_lambda_det(w,c,n,tau,alpha,sigma,gamma)

dV_dtau        = fn_dV_dtau_det(w,c,n,tau,alpha,sigma,gamma);
lambda         = fn_lambda_det(c,n,alpha,sigma,gamma);

dV_dtau_lambda = dV_dtau./lambda;

end