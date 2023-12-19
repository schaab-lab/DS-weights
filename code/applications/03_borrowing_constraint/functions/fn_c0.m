function c0 = fn_c0(b,k0,q0,n0,phi)

upsilon = fn_upsilon(phi,k0);

c0      = n0 - upsilon + q0*b;

end