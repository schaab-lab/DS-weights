function [dW,Xi_AE,Xi_RD,Xi_RS,Xi_IS] = fn_welfare_decomp(omega_i,omega_s_L_i,omega_s_H_i,omega_0_i,omega_1_i,dc0,dc1_L,dc1_H,dV_lambda)

omega_0   = mean(omega_0_i);   omega_1   = mean(omega_1_i);
omega_s_L = mean(omega_s_L_i); omega_s_H = mean(omega_s_H_i);

% Aggregate Efficiency
Xi_AE         = omega_0*sum(dc0) ...
              + omega_1*(omega_s_L*sum(dc1_L) + omega_s_H*sum(dc1_H));

% Redistribution
Xi_RD         = fn_covar(omega_i,dV_lambda,2);

% Risk-Sharing
tmp_L         = fn_covar(omega_s_L_i./omega_s_L,dc1_L,2);
tmp_H         = fn_covar(omega_s_H_i./omega_s_H,dc1_H,2);

Xi_RS         = omega_1*(omega_s_L*tmp_L+omega_s_H*tmp_H);

% Intertemporal-Sharing
Xi_IS         = omega_0*fn_covar(omega_0_i./omega_0,dc0,2)...
              + omega_1*fn_covar(omega_1_i./omega_1, omega_s_L_i.*dc1_L + omega_s_H_i.*dc1_H,2);

% dW\dtau
dW            = Xi_AE + Xi_RD + Xi_RS + Xi_IS;
%dW            = sum([omega_i(1)*dV_lambda(1), omega_i(2)*dV_lambda(2)]);

end

