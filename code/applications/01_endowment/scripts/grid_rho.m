
% Grid
rho_grid = (0.5:0.01:1)';

%% Fixed theta (theta = 0)

grid_rho_fixed_theta;

%% Grid theta

grid_rho_grid_theta;

%% Figures

fig_theta_0_rho_grid(rho_grid,dW_rho,Xi_AE_rho,Xi_RS_rho,Xi_IS_rho,Xi_RD_rho,optfig)
fig_theta_grid_rho_grid(rho_grid,dW_rho_theta,Xi_AE_rho_theta,Xi_RS_rho_theta,Xi_IS_rho_theta,Xi_RD_rho_theta,optfig)
