function fig_app1_theta(theta_grid,dV_lambda,dW,Xi_AE_theta,Xi_RS_theta,Xi_IS_theta,Xi_RD_theta,c_theta,rho,optfig)

W_theta = fn_global(dW,theta_grid);

% Figures
fig_welfare_assessment(theta_grid,dV_lambda,dW,Xi_AE_theta,Xi_RS_theta,Xi_IS_theta,Xi_RD_theta,rho,optfig)
fig_c_theta(theta_grid,c_theta,rho,optfig)
fig_welfare(theta_grid, W_theta,rho,optfig)

end