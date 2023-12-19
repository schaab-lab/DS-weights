function V = fn_V(c,n,alpha,sigma,gamma)

tmp = c - alpha .* ((n.^sigma)./sigma);

V   = (tmp.^(1-gamma))./(1-gamma);

end