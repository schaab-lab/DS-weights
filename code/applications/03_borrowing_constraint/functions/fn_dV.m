function dV = fn_dV(b,k0,q0,dc0,dc1_L,dc1_H,n0,n1,z,pi,gamma,phi,beta)

u_prime = fn_u_prime(b,k0,q0,n0,n1,z,gamma,phi);

dV      = u_prime(1)*dc0 + beta*(pi(1)*u_prime(2)*dc1_L + pi(2)*u_prime(3)*dc1_H);

end