function n = fn_n_opt(w,tau,alpha,sigma)

n = ((1/alpha).*(1-tau).*w).^(1/(sigma-1));

end