function dV_dtau = fn_dV_dtau_rand(w_L,w_H,c_L,c_H,n_L,n_H,omega_s_L,omega_s_H,tau,pi,alpha,sigma,gamma)

lambda    = fn_lambda_rand(c_L,c_H,n_L,n_H,pi,alpha,sigma,gamma);

E_L       = fn_E(w_L,n_L);
E_H       = fn_E(w_H,n_H);

dE_dtau_L = fn_dE_dtau(w_L,n_L,sigma,alpha);
dE_dtau_H = fn_dE_dtau(w_H,n_H,sigma,alpha);

dg_L      = (1/length(w_L))*(E_L + tau*dE_dtau_L);
dg_H      = (1/length(w_H))*(E_H + tau*dE_dtau_H);

dV_dtau   = lambda.*(omega_s_L.*(-w_L.*n_L + dg_L) + omega_s_H.*(-w_H.*n_H + dg_H));

end