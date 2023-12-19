function resid = fn_k_resid(x,b,q0,n0,n1,z,pi,gamma,phi,beta)

u_prime = fn_u_prime(b,x,q0,n0,n1,z,gamma,phi);

resid   = phi.*x.*u_prime(1) - beta*(pi(1)*u_prime(2)*z(1)+pi(2)*u_prime(3)*z(2));

end