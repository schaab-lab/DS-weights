function [dW,Xi_AE,Xi_RD,Xi_RS,Xi_IS,TS] = fn_welfare_decomp(omega_i,omega_s_i,omega_t_i,dV_lambda_t,dV_lambda_t_s,S,T,I)

TS.omega_t                            = zeros(S,T);
[TS.omega_s,cov_RS]                   = deal(zeros(S,S,T));
[TS.Xi_AE,TS.Xi_RD,TS.Xi_RS,TS.Xi_IS] = deal(zeros(S,T));
[Xi_AE,Xi_RD,Xi_RS,Xi_IS,dW]          = deal(zeros(S,1));

%% Auxiliary Computations

% Average Dynamic Weights
for s = 1:S
    for t = 1:T
        TS.omega_t(s,t)   = mean(omega_t_i(s,t,:));
    end
end

% Average Stochastic Weights
for s = 1:S
    for t = 1:T
        TS.omega_s(s,:,t) = mean(omega_s_i(s,:,t,:),4);
    end
end

% Covariance Used in Risk-Sharing
for s0 = 1:S
    for s1 = 1:S
        parfor t = 1:T
            cov_RS(s0,s1,t) = fn_covar(squeeze(omega_s_i(s0,s1,t,:)),dV_lambda_t_s(s1,:),I);
        end
    end
end
    
%% Aggregate Additive Decomposition Over Time
for s = 1:S
    for t = 1:T

        % Aggregate Efficiency Over Time
        TS.Xi_AE(s,t) = TS.omega_t(s,t)*sum(squeeze(TS.omega_s(s,:,t)).*sum(dV_lambda_t_s));

        % Redistribution Over Time
        TS.Xi_RD(s,t) = fn_covar(omega_i(s,:),squeeze(omega_t_i(s,t,:)).*squeeze(dV_lambda_t(s,t,:)),I);

        % Risk-Sharing Over Time
        TS.Xi_RS(s,t) = TS.omega_t(s,t)*sum(squeeze(cov_RS(s,:,t)));
        
        % Intertemporal-Sharing Over Time
        TS.Xi_IS(s,t) = TS.omega_t(s,t)*fn_covar(squeeze(omega_t_i(s,t,:)./TS.omega_t(s,t)),squeeze(dV_lambda_t(s,t,:)),I);

    end
end

%% Aggregate Additive Decomposition
parfor s = 1:S
    
    % Aggregate Efficiency
    Xi_AE(s) = sum(TS.Xi_AE(s,:));

    % Redistribution
    Xi_RD(s) = sum(TS.Xi_RD(s,:));

    % Risk-Sharing
    Xi_RS(s) = sum(TS.Xi_RS(s,:));

    % Intertemporal-Sharing
    Xi_IS(s) = sum(TS.Xi_IS(s,:));

    % dW
    dW(s)    = Xi_AE(s) + Xi_RD(s) + Xi_RS(s) + Xi_IS(s);

end


end