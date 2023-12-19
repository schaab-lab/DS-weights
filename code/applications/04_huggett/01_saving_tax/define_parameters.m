function param = define_parameters(varargin)

%% GRID PARAMETERS

% Grid construction:
param.l = 7;
param.d = 1; param.d_idio = 1; param.d_agg = 0;

param.l_dense = 7; % vector of "surplus" for dense grid

param.amin = -1;
param.amax = 20;

param.min = [param.amin];
param.max = [param.amax];

% Grid adaptation:
param.add_rule = 'tol';
param.add_tol = 1e-5;
param.keep_tol = 1e-6; 
param.max_adapt_iter = 20;
if param.keep_tol >= param.add_tol, error('keep_tol should be smaller than add_told\n'); end

%% PDE TUNING PARAMETERS
param.Delta = 1000;
param.maxit = 100;
param.crit  = 1e-8;

param.Delta_KF = 1000;
param.maxit_KF = 100;
param.crit_KF  = 1e-8;


%% POLICY EXPERIMENTS
param.num_theta = 30;
param.theta_max = 0.2;
param.theta_min = -0.05;
param.dtheta = (param.theta_max - param.theta_min) / (param.num_theta - 1);

%% TIME GRID PARAMETERS

param.time_grid_adjustment = 0;
param.T = 50; 
param.N = 500;
param.N_fine = param.N * 10;

param.t  = linspace(0, param.T, param.N);
param.dt = param.t(2) - param.t(1);

if 6 * param.T > param.N; param.implicit = 1; else; param.implicit = 0; end

param.bfun_type = "nodal"; 
param.cheb_H = 25;

param.H(1) = param.N; if param.bfun_type == "cheb", param.H(1) = param.cheb_H; end
param.H(2) = 1; % # of time series to guess 

% Time grid for steady state welfare effect
param.ss_T = 1000; 
param.ss_N = 10000;


%% ECONOMIC PARAMETERS

% Household parameters:
param.rho = 0.02;
param.gamma = 2;

param.zz  = [0.8, 1.2];
param.la1 = 1/3;
param.la2 = 1/3;
param.L   = param.la1/(param.la1+param.la2) * param.zz(1) + param.la2/(param.la1+param.la2) * param.zz(2);

param.discrete_types = numel(param.zz);

param.u     = @(x) x.^(1-param.gamma) / (1-param.gamma); 
param.u1    = @(x) x.^(-param.gamma);
param.u1inv = @(x) x.^(-1/param.gamma);


%% VARIABLE INPUTS

% Parse inputs:
p = inputParser;
p.CaseSensitive = true;
for f = fieldnames(param)'
    p.addParameter(f{:}, param.(f{:}));
end
parse(p, varargin{:});
param = p.Results;

% % Update parameters
% param.t = linspace(0, param.T, param.N)';
% if param.time_grid_adjustment == 1
%     if param.N / param.T >= 2
%         adjustment = @(x) x; 
%     elseif param.N / param.T >= 1
%         adjustment = @(x) (exp(x/param.T)-1) * param.T / (exp(1)-1);
%     elseif param.N / param.T > 0.8
%         adjustment = @(x) x.^2 / param.T^1;
%     else 
%         adjustment = @(x) x.^3 / param.T^2;
%     end
%     param.t = adjustment(param.t);
% end
% param.dt = diff(param.t); param.dt(param.N) = param.dt(param.N-1);
% 

param.t  = linspace(0, param.T, param.N);
param.dt = param.t(2) - param.t(1);

if 6 * param.T > param.N; param.implicit = 1; else; param.implicit = 0; end

param.H(1) = param.N; if param.bfun_type == "cheb", param.H(1) = param.cheb_H; end


end