function output = fn_u_prime(b,k0,q0,n0,n1,z,gamma,phi)

% Capital Adjustment Costs
upsilon   = fn_upsilon(phi,k0);

% Date 0: Marginal Utility
output(1) = (n0 - upsilon + q0.*b).^(-gamma);

% Date 1: Marginal Utility
output(2) = (n1(1)+z(1).*k0-b).^(-gamma); % z = L
output(3) = (n1(2)+z(2).*k0-b).^(-gamma); % z = H

end