function param = define_parameters(varargin)

%% PDE TUNING PARAMETERS
param.Delta = 1000;
param.maxit = 100;
param.crit  = 1e-8;

param.Delta_KF = 1000;
param.maxit_KF = 100;
param.crit_KF  = 1e-8;


%% TIME GRID FOR WELFARE ASSESSMENTS
param.T = 120; % quarters
param.N = param.T * 4;

param.t  = linspace(0, param.T, param.N);
param.dt = param.t(2) - param.t(1);

%% SOCIAL WELFARE FUNCTIONS
param.phi     = [1, 5, 10]';
param.num_phi = numel(param.phi);
param.iso_SWF = @(a,V,phi) sum(a.*(-V).^phi).^(1/phi);
param.pareto  = @(alpha,V,phi) alpha .* ((-V)'./param.iso_SWF(ones(2,1)./2,V',phi)).^(phi-1);

%% ECONOMIC PARAMETERS

% Household parameters:
param.rho = -log(0.95);
param.gamma = 2;

param.z1  = 0.75;
param.z2  = 1.25;
param.la1 = 1/3;
param.la2 = 1/3;
param.L   = param.la2/(param.la1+param.la2) * param.z1 + param.la1/(param.la1+param.la2) * param.z2;

param.u     = @(x) x.^(1-param.gamma) / (1-param.gamma); 
param.u1    = @(x) x.^(-param.gamma);
param.u1inv = @(x) x.^(-1/param.gamma);

% Policies:
param.num_theta = 20;
param.theta_min = 0;
param.theta_max = 1.5;


%% VARIABLE INPUTS

% Parse inputs:
p = inputParser;
p.CaseSensitive = true;
for f = fieldnames(param)'
    p.addParameter(f{:}, param.(f{:}));
end
parse(p, varargin{:});
param = p.Results;

% Update parameters:


end