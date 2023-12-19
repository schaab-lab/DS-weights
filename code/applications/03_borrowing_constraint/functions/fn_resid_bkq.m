function resid = fn_resid_bkq(x,beta,n0,n1,z,pi,gamma,phi)

% Definitions
b1        = x(1);
b2        = x(2);
k0        = x(3);
q0        = x(4);

% Marginal Utilities
u_prime_1 = fn_u_prime(b1,k0,q0,n0(1),n1(1,:),z,gamma(1),phi);
u_prime_2 = fn_u_prime(b2,0,q0,n0(2),n1(2,:),z,gamma(2),phi);

% Borrowing F.O.Cs
resid(1)  = q0*u_prime_1(1) - beta(1)*(pi(1)*u_prime_1(2)+pi(2)*u_prime_1(3));
resid(2)  = q0*u_prime_2(1) - beta(2)*(pi(1)*u_prime_2(2)+pi(2)*u_prime_2(3));

% Investment F.O.C
resid(3)  = phi*k0*u_prime_1(1) - beta(1)*(pi(1)*u_prime_1(2)*z(1)+pi(2)*u_prime_1(3)*z(2));

% Market clearing
resid(4)  = b1+b2;

end