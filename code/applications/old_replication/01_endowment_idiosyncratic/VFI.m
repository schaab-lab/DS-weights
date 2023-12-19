function V = VFI(P, G, param)

V = P.V0;

for iter = 1:param.maxit

% Set up linear system:
B = (1/param.Delta + param.rho)*speye(2) - G.Az;
b = [P.u(:, 1); P.u(:, 2)] + [V(:, 1); V(:, 2)] / param.Delta;

% Solve linear system:
V_new = B\b;

% Update:
V_change = V_new - [V(:, 1); V(:, 2)];
V = [V_new(1), V_new(2)];

dist = max(max(abs(V_change)));
if dist < param.crit; break; end

% if mod(iter, 1) == 0, fprintf('VFI: %.i    Remaining Gap: %.2d\n', iter, dist); end
if ~isreal(V), fprintf('Complex values in VFI: terminating process.'); V = NaN(1); return; end

end

if iter == param.maxit, fprintf('VFI did not converge. Remaining Gap: %.2d\n', iter, dist); V = NaN(1); return; end

end
