function resid = fn_resid_q(x,beta,n0,n1,z,pi,gamma,phi,b_bar)

% Definitions
b2        = -b_bar;
q0        = x;

% Marginal Utilities
u_prime_2 = fn_u_prime(b2,0,q0,n0(2),n1(2,:),z,gamma(2),phi);

% Borrowing F.O.Cs
resid(1)  = q0*u_prime_2(1) - beta(2)*(pi(1)*u_prime_2(2)+pi(2)*u_prime_2(3));

end