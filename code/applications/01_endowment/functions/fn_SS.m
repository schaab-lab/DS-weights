function [transition,SS,transition_Tstar,SS_Tstar] = fn_SS(TS)

W_t = TS.Xi_AE(1,:) + TS.Xi_RS(1,:) + TS.Xi_IS(1,:) + TS.Xi_RD(1,:);

T   = length(W_t);

[transition,SS,transition_Tstar,SS_Tstar,discount] = deal(zeros(T,1));

for i=1:T
    transition(i)       = sum(W_t(1:i));
    SS(i)               = sum(W_t(i+1:end));

    discount(i)         = sum(TS.omega_t(1,i+1:end));
    transition_Tstar(i) = sum(W_t(1:i))./discount(i);
    SS_Tstar(i)         = sum(W_t(i+1:end))./discount(i);
     
end

end