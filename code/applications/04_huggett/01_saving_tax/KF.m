function g = KF(s, G, param)

Az = [-speye(G.J)*param.la1,  speye(G.J)*param.la1; ...
       speye(G.J)*param.la2, -speye(G.J)*param.la2];

Aa{1} = FD_operator(G, s(:, 1), zeros(G.J,  1), 1, '1');
Aa{2} = FD_operator(G, s(:, 2), zeros(G.J,1), 1, '2');

AT = (blkdiag(Aa{1}, Aa{2}) + Az)';

% KF #1:
AT1 = AT;
b = zeros(param.discrete_types * G.J, 1);

i_fix = 1;
b(i_fix) = 0.1;
row = [zeros(1,i_fix-1),1,zeros(1,param.discrete_types*G.J-i_fix)];
AT1(i_fix,:) = row;

gg = AT1 \ b;
g_sum = gg' * ones(param.discrete_types*G.J, 1) * G.dx;
gg = gg ./ g_sum;

g1 = [gg(1:G.J),gg(G.J+1:2*G.J)];


% KF #2:
g = zeros(G.J, param.discrete_types);
g(G.a == param.amin, :) = 1/numel(param.zz) / G.da;

for n = 1:param.maxit_KF   
    B = 1/param.Delta_KF .* speye(param.discrete_types*G.J) - AT;
    b = [g(:,1); g(:,2)] / param.Delta_KF;

    g_new = B\b;

    diff = max(abs( [g(:,1); g(:,2)] - g_new ));
    if diff < param.crit_KF, break; end
    g = [g_new(1:G.J), g_new(1+G.J:end)];    
end
if n == param.maxit_KF, fprintf('KF did not converge. Remaining Gap: %.2d\n', diff); end


% Some tests:
mass = sum(g * G.da);
if abs(sum(mass)-1) > 1e-5, fprintf('Distribution not normalized!\n'); end
if max(max(abs(g1 - g))) > 1e-5, fprintf('Distributions g1 and g2 do not align!\n'); end


end