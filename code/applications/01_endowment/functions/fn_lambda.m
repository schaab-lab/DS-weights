function output = fn_lambda(u_prime,beta,Pi,S)

output      = (eye(S)-beta.*Pi)\u_prime;

end
