function hjb = HJB(V, G, param)

VaF = zeros(G.J, param.discrete_types);
VaB = zeros(G.J, param.discrete_types);
for j = 1:param.discrete_types
    VaF(:, j) = deriv_sparse(G, V(:, j), 1, 'D1F', num2str(j));
    VaB(:, j) = deriv_sparse(G, V(:, j), 1, 'D1B', num2str(j));
end

% u'(c) = Va
cF = param.u1inv(1/param.factor .* VaF);
cB = param.u1inv(1/param.factor .* VaB);
c0 = G.income;

sF = G.income - cF;
sB = G.income - cB;

IF = (sF>0) .* (G.grid(:,1)<1);  
IB = (sB<0) .* (IF==0) .* (G.grid(:,1)>0);
I0 = (1-IF-IB);

s = sF.*IF + sB.*IB;
c = cF.*IF + cB.*IB + c0.*I0;
u = param.u(c);

dV = VaF.*IF + VaB.*IB + param.u1(c0).*I0;

% COLLECT OUTPUT
hjb.c = c; hjb.s = s; hjb.u = u; hjb.dV = dV;

for j = 1:param.discrete_types, hjb.mu{j}  = s(:,j); end
for j = 1:param.discrete_types, hjb.sig{j} = zeros(G.J, 1); end

end




