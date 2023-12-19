function [dV_lambda, dV_lambda_t, dV_lambda_t_s] = fn_dV(omega_s,omega_t,Ts,S,T,I)

dV_lambda_t                = zeros(S,T,I);
dV_lambda                  = zeros(S,I);


% dV|lambda that varies over time and histories
dV_lambda_t_s              = Ts;

% dV|lambda that varies over time
for s = 1:S
    parfor t = 1:T
        dV_lambda_t(s,t,:) = sum(squeeze(omega_s(s,:,t,:)).*dV_lambda_t_s);
    end
end

% dV|lambda that varies across individuals
for s = 1:S
    parfor i = 1:I
        dV_lambda(s,i)     = sum(squeeze(omega_t(s,:,i)).*squeeze(dV_lambda_t(s,:,i)));
    end
end

end
