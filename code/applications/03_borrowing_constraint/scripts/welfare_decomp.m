
[omega_i,omega_0_i,omega_1_i,omega_s_L_i,omega_s_H_i,dV_i,dV_lambda] = deal(zeros(length(b_bar_grid),2));
[dW,Xi_AE,Xi_RD,Xi_RS,Xi_IS]                                         = deal(zeros(length(b_bar_grid),1));

%% Building up gradients
db    = [gradient(b0_opt(:,1),b_bar_grid), gradient(b0_opt(:,2),b_bar_grid)];
dq0   = gradient(q0_opt,b_bar_grid);
dk0   = gradient(k0_opt,b_bar_grid);
dc0   = [dq0.*b0_opt(:,1)+q0_opt.*db(:,1)-phi.*k0_opt.*dk0,...
         dq0.*b0_opt(:,2)+q0_opt.*db(:,2)];
dc1_L = [z(1).*dk0-db(:,1), -db(:,2)];
dc1_H = [z(2).*dk0-db(:,1), -db(:,2)];

parfor i = 1:length(b_bar_grid)
    b      = b0_opt(i,:);
    dc_0   = dc0(i,:);
    dc_1_L = dc1_L(i,:);
    dc_1_H = dc1_H(i,:);

    % dV/db_bar
    dV_i(i,:) = [fn_dV(b(1),k0_opt(i),q0_opt(i),dc_0(1),dc_1_L(1),dc_1_H(1),n0(1),n1(1,:),z,pi,gamma(1),phi,beta(1)),...
                 fn_dV(b(2),0,q0_opt(i),dc_0(2),dc_1_L(2),dc_1_H(2),n0(2),n1(2,:),z,pi,gamma(2),phi,beta(2))];

    % dV/db_bar/lambda
    dV_lambda(i,:) = [fn_dV_lambda(b(1),k0_opt(i),q0_opt(i),dc_0(1),dc_1_L(1),dc_1_H(1),n0(1),n1(1,:),z,pi,gamma(1),phi,beta(1)),...
                      fn_dV_lambda(b(2),0,q0_opt(i),dc_0(2),dc_1_L(2),dc_1_H(2),n0(2),n1(2,:),z,pi,gamma(2),phi,beta(2))];
end

fig_V_dV(b_bar_grid,b0_unconstrained,V_opt,dV_i,dV_lambda,optfig)

%% Welfare Assessment
parfor i = 1:length(b_bar_grid)

    % DS-Weights
    [omega_i(i,:),omega_s_L_i(i,:),omega_s_H_i(i,:),omega_0_i(i,:),omega_1_i(i,:)] = fn_weights(b0_opt(i,:),k0_opt(i,:),q0_opt(i),n0,n1,z,pi,gamma,phi,beta);

    % Aggregate Additive Decomposition
    [dW(i),Xi_AE(i),Xi_RD(i),Xi_RS(i),Xi_IS(i)] = fn_welfare_decomp(omega_i(i,:),omega_s_L_i(i,:),omega_s_H_i(i,:),omega_0_i(i,:),omega_1_i(i,:),dc0(i,:),dc1_L(i,:),dc1_H(i,:),dV_lambda(i,:));

end

fig_weights(b_bar_grid,b0_unconstrained,omega_i,omega_0_i,omega_1_i,omega_s_L_i,omega_s_H_i,optfig)
fig_welfare(b_bar_grid,b0_unconstrained,dW,dV_lambda,Xi_AE,Xi_RS,Xi_IS,Xi_RD,optfig)

%% Check (it should be the same as the previous dV_lambda)
dV_lambda_check = zeros(length(b_bar_grid),2);
parfor i = 1:length(b_bar_grid)
    dV_lambda_check(i,:) = [omega_0_i(i,1).*dc0(i,1) + omega_1_i(i,1).*(omega_s_L_i(i,1).*dc1_L(i,1)+omega_s_H_i(i,1).*dc1_H(i,1)),...
                            omega_0_i(i,2).*dc0(i,2) + omega_1_i(i,2).*(omega_s_L_i(i,2).*dc1_L(i,2)+omega_s_H_i(i,2).*dc1_H(i,2))];
end
