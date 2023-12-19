function dV_lambda = fn_dV_lambda(b,k0,q0,dc0,dc1_L,dc1_H,n0,n1,z,pi,gamma,phi,beta)

dV        = fn_dV(b,k0,q0,dc0,dc1_L,dc1_H,n0,n1,z,pi,gamma,phi,beta);

lambda    = fn_lambda(b,k0,q0,n0,n1,z,pi,gamma,phi,beta);

dV_lambda = dV/lambda;

end