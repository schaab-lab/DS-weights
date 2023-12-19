function dV_dtau_lambda = fn_dV_dtau_lambda_rand(w_L,w_H,c_L,c_H,n_L,n_H,omega_s_L,omega_s_H,tau,pi,alpha,sigma,gamma)

dV_dtau        = fn_dV_dtau_rand(w_L,w_H,c_L,c_H,n_L,n_H,omega_s_L,omega_s_H,tau,pi,alpha,sigma,gamma);
lambda         = fn_lambda_rand(c_L,c_H,n_L,n_H,pi,alpha,sigma,gamma);

dV_dtau_lambda = dV_dtau./lambda;

end