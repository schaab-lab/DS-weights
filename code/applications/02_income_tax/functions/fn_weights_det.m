function [omega_i] = fn_weights_det(c,n,alpha,sigma,gamma)

lambda       = fn_lambda_det(c,n,alpha,sigma,gamma);

% Individual Weights
omega_i      = lambda./mean(lambda);

end