% Welfare Assessments with Heterogeneous Individuals:
% Linear Income Taxation, 12/07/2023

run scripts/start_whh_app2.m

% Parameters
gamma = 0.5;       % GHH Preferences
sigma = 2;         % isoelastic labor parameter
alpha = 1;         % labor coefficient
pi    = [0.5,0.5]; % States Probabilities

% Wages
wages_det  = [1,5];
wages_rand = [wages_det(1),wages_det(2);
    wages_det(2),wages_det(1)];

% Tax Grid
[tau_min,tau_max,tau_spc] = deal(0,1,0.0001);
tau_grid                  = (tau_min:tau_spc:tau_max);

% Deterministic Environment
deterministic_earnings;

% Stochastic Environment
random_earnings;

% Analytical vs Numerical
test_numerical;

fig_agg(tau_grid,tau_opt_det,C_det,N_det,W_det,C_rand,N_rand,W_rand,optfig)
fig_welfare(tau_grid,dW_det,Xi_AE_det,Xi_RD_det,Xi_RS_det,dW_rand,Xi_AE_rand,Xi_RD_rand,Xi_RS_rand,dV_lambda_det,dV_lambda_rand,tau_opt_det,tau_opt_rand,optfig)

toc;
