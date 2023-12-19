function output = fn_partial_W_partial_V(V,a,phi)

if phi == 0
    output = a.*(V.^(a-1));
else
    output = a.*(V.^(phi-1));
end


end