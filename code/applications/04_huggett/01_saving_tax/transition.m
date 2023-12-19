function [diff, G, G_dense, sim] = transition(PHI, G, G_dense, ss, param)

%% SETUP
sim.N  = param.N;
sim.t  = param.t;
sim.dt = param.dt;

% PREALLOCATE
sim.V  = cell(param.N, 1);
sim.A  = cell(param.N, 1);
sim.g  = cell(param.N, 1);
sim.gg = cell(param.N, 1);
sim.c  = cell(param.N, 1);
sim.s  = cell(param.N, 1);
sim.C = zeros(param.N, 1);
sim.B = zeros(param.N, 1);
sim.S = zeros(param.N, 1);


%% AGGREGATE TRANSITION PATH
X = basis_fun_irf([], reshape(PHI, [1, numel(PHI)]), param.H(1), param.H(2), ...
    param.bfun_type, sim.t, "get_function");

sim.r = X(:,1); 
sim.L = param.L * ones(param.N, 1);
sim.Y = sim.L;
sim.w = ones(param.N, 1);

%% SOLVE VFI BACKWARDS
V = ss.V;
sim.g{1} = G.g;

Az = [-speye(G.J)*param.la1,  speye(G.J)*param.la1; ...
       speye(G.J)*param.la2, -speye(G.J)*param.la2];

for n = param.N:-1:1
    
    G.income = sim.r(n) * G.a + sim.w(n) .* param.zz;
    
    % POLICY FUNCTIONS
    num0 = 1e-8; % numerical 0 for upwind scheme

    VaF = zeros(G.J, param.discrete_types);
    VaB = zeros(G.J, param.discrete_types);
    for j = 1:param.discrete_types
        VaF(:, j) = deriv_sparse(G, V(:, j), 1, 'D1F', num2str(j));
        VaB(:, j) = deriv_sparse(G, V(:, j), 1, 'D1B', num2str(j));
    end
    
    VaF(G.grid(:, 1) == 1, :) = param.u1(G.income(G.grid(:, 1) == 1, :));
    VaB(G.grid(:, 1) == 0, :) = param.u1(G.income(G.grid(:, 1) == 0, :));
    
    cF = param.u1inv((1-param.theta)*VaF);
    cB = param.u1inv((1-param.theta)*VaB);
    c0 = G.income;

    sF = (1-param.theta) * (G.income - cF);
    sB = (1-param.theta) * (G.income - cB);

    IF = (sF>0) .* (G.grid(:,1)<1);  
    IB = (sB<0) .* (IF==0) .* (G.grid(:,1)>0);
    I0 = (1-IF-IB);
    
    s = sF.*IF + sB.*IB;
    c = cF.*IF + cB.*IB + c0.*I0;
    u = param.u(c);
    
    % CONSTRUCT FD OPERATORS
    Aa{1} = FD_operator(G, s(:,1), zeros(G.J,1), 1, '1');
    Aa{2} = FD_operator(G, s(:,2), zeros(G.J,1), 1, '2');

    A = blkdiag(Aa{1}, Aa{2}) + Az;

    B = (1/sim.dt + param.rho)*speye(2*G.J) - A;
    b = u(:) + V(:) / sim.dt;    
    
    % SOLVE LINEAR SYSTEM
    V = reshape(B\b, [G.J, 2]);    
    if ~isreal(V), disp('Complex values detected!'); diff = NaN(1); return; end
    
    % RECORD DATA
    sim.V{n} = V; sim.u{n} = u; sim.c{n} = c; sim.s{n} = s; sim.A{n} = A;
    
end


%% SOLVE KF FORWARDS
Az_dense = Az;

for n = 1:param.N
    
    % For KF, we are lucky and don't have to worry about BCs here because
    % drift is already inward-pointing.
    Aa_dense{1} = FD_operator(G_dense, G.BH_dense * sim.s{n}(:, 1), zeros(G_dense.J,1), 1, '1');
    Aa_dense{2} = FD_operator(G_dense, G.BH_dense * sim.s{n}(:, 2), zeros(G_dense.J,1), 1, '2');
    
    AT = (blkdiag(Aa_dense{1}, Aa_dense{2}) + Az_dense)';
    
    if param.implicit
        % Implicit:
        B = 1/sim.dt * speye(2*G_dense.J) - AT;
        b = sim.g{n} / sim.dt;
        sim.g{n+1} = B \ b;        
    else
        % Explicit: (for explicit, N should be >6 times larger than T)
        sim.g{n+1} = sim.g{n} + sim.dt * AT * sim.g{n};
    end
    
    % Ensure positive density:
    sim.g{n+1}(sim.g{n+1} < 0) = 0;    
    if abs( sum(sum(sim.g{n+1} * G_dense.dx )) - sum(sum(sim.g{n} * G_dense.dx ))) > 1e-6
        fprintf('KF not preserving mass.\n');
    end
    
    sim.gg{n} = [sim.g{n}(1:G.J), sim.g{n}(G.J+1:end)];
    
end


%% AGGREGATION & MARKET CLEARING
for n = 1:param.N    
    
    c_dense = G.BH_dense * sim.c{n};
    s_dense = G.BH_dense * sim.s{n};

    sim.mass(n,:) = sum(sim.g{n}*G_dense.dx);

    sim.B(n) = sum(sum(G_dense.a .* sim.gg{n} .* G_dense.dx));
    sim.C(n) = sum(sum(c_dense .* sim.gg{n} .* G_dense.dx));
    sim.S(n) = sum(sum(s_dense .* sim.gg{n} .* G_dense.dx));

end

sim.excess_bonds = sim.B;
sim.excess_goods = sim.Y - sim.C;
sim.excess_saving = sim.S;


%% COLLOCATION POINTS

DIFF_Y = interp1(sim.t, sim.excess_goods, param.nodes);
DIFF_B = interp1(sim.t, sim.excess_bonds, param.nodes);
DIFF_S = interp1(sim.t, sim.excess_saving, param.nodes);

diff = DIFF_S';


end




