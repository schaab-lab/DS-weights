function output = fn_u_prime_c(c,n,alpha,sigma,gamma)

tmp    = c - alpha .* ((n.^sigma)./sigma);

output = tmp.^(-gamma);

end