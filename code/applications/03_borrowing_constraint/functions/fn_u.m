function u = fn_u(c0,c1,beta,pi,gamma)

f_u = @(x) (x^(1-gamma))/(1-gamma);

u   = f_u(c0) + beta*(pi(1)*f_u(c1(1))+pi(2)*f_u(c1(2)));

end