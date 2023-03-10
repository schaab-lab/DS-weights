function P = density(j, n, P_old, ss, G, param)

if n == 1, P = eye(param.discrete_types * G.J, param.discrete_types * G.J); return; end

if param.implicit
    % Implicit time iteration:
    B = 1/param.dt .* speye(param.discrete_types * G.J) - ss{j}.A';
    b = P_old / param.dt;

    P = B\b;

else
    % Explicit time iteration:
    P = P_old + param.dt * ss{j}.A' * P_old;

end

% exact (but slow) solution
% P = expm(n * ss{j}.A');

assert(abs(sum(sum(((P' .* ss{j}.g(:))))) - 1) < 1e-5, ...
    'Transition probability not normalized.') % G.da already in ss{j}.g
    
end

