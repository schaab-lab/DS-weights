function g = fn_g(w,n,tau)

E = fn_E(w,n);
g = tau*(1/length(w))*E;

end