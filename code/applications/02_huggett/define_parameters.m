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

% Time grid: 
param.T = 500; % quarters
param.N = 500;

param.implicit = 0; if param.N > 6 * param.T, param.implicit = 1; end

param.t  = linspace(0, param.T, param.N);
param.dt = param.t(2) - param.t(1);


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

% Update parameters


end