function lambda = fn_lambda_rand(c_L,c_H,n_L,n_H,pi,alpha,sigma,gamma)

lambda = pi(1).*fn_u_prime_c(c_L,n_L,alpha,sigma,gamma) + pi(2).*fn_u_prime_c(c_H,n_H,alpha,sigma,gamma);

end

