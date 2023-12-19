function output = fn_covar(x,y,I)

tmp    = cov(x,y,1);

output = I*tmp(1,2);

end

