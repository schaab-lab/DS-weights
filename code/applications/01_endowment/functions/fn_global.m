function W = fn_global(dW,theta_grid)

W = zeros(size(dW));
h = theta_grid(2) - theta_grid(1);

for j = 2:length(theta_grid)
    W(:,j) = W(:,j-1) + dW(:,j-1)*h;
end

end