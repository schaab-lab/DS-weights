function lambda = fn_lambda(b,k0,q0,n0,n1,z,pi,gamma,phi,beta)

u_prime = fn_u_prime(b,k0,q0,n0,n1,z,gamma,phi);

lambda  = u_prime(1) + beta*(pi(1)*u_prime(2)+pi(2)*u_prime(3));

end