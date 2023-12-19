function dn_dtau = fn_dn_dtau(w,n,sigma,alpha)

dn_dtau = - (1./(sigma-1)) .* (1./alpha) .* w .* (n.^(2-sigma));

end