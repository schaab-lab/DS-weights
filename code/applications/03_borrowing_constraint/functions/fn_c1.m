function c1 = fn_c1(b,k0,n1,z)

c1(1) = n1(1) + z(1)*k0 - b; % z = L
c1(2) = n1(2) + z(2)*k0 - b; % z = H

end