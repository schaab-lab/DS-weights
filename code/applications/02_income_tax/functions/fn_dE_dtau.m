function dE_dtau = fn_dE_dtau(w,n,sigma,alpha)

dn_dtau = fn_dn_dtau(w,n,sigma,alpha);

dE_dtau = sum(w.*dn_dtau);

end