function P = density(j, n, P_old, sim, G, param)

if n == 1, P = eye(param.discrete_types * G.J, param.discrete_types * G.J); return; end

if param.implicit
    % Implicit time iteration:
    B = 1/param.dt .* speye(param.discrete_types * G.J) - sim{j}.A{n}';
    b = P_old / param.dt;

    P = B\b;

else
    % Explicit time iteration:
    P = P_old + param.dt * sim{j}.A{n}' * P_old;

end

assert(abs(sum(sum(((P' .* G.g)))) - 1) < 1e-5, ...
    'Transition probability not normalized.') % G.da already in ss{j}.g
    
end

