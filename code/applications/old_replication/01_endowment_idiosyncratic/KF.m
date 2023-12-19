function g = KF(Az, G, param)

AT = Az';

% KF #1:
AT1 = AT;
b = zeros(2, 1);

i_fix = 1;
b(i_fix) = 0.1;
row = [zeros(1, i_fix-1),1,zeros(1, 2-i_fix)];
AT1(i_fix, :) = row;

gg = AT1 \ b;
g_sum = gg' * ones(2, 1);
gg = gg ./ g_sum;

g1 = [gg(1), gg(2)];


% KF #2:
g = zeros(1, 2);
g(1, :) = 1/2;

for n = 1:param.maxit_KF   
    B = 1/param.Delta_KF .* speye(2) - AT;
    b = [g(:, 1); g(:, 2)] / param.Delta_KF;

    g_new = B\b;

    diff = max(abs( [g(:, 1); g(:, 2)] - g_new ));
    if diff < param.crit_KF, break; end
    g = [g_new(1), g_new(2)];    
end
if n == param.maxit_KF, fprintf('KF did not converge. Remaining Gap: %.2d\n', diff); end


% Some tests:
mass = sum(g);
if abs(sum(mass)-1) > 1e-5, fprintf('Distribution not normalized!\n'); end
if max(max(abs(g1 - g))) > 1e-5, fprintf('Distributions g1 and g2 do not align!\n'); end


end