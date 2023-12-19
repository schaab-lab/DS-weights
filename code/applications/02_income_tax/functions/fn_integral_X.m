function X_numerical = fn_integral_X(X,dX,grid,grid_stp)

X_numerical    = zeros(length(grid),1);
X_numerical(1) = X(1);

stp = grid_stp;

for i= 2:length(grid)
    X_numerical(i) = X_numerical(i-1) + ((dX(i-1)+dX(i))/2)*stp;
end

end

