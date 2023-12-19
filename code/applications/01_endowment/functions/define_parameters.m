function param = define_parameters(varargin)

%% MODEL PARAMETERS

param.beta  = [0.95, 0.95];
param.gamma = [2,2];
param.y_bar = [1 , 1];
param.eps   = [-0.25, 0.25]';
param.rho   = 0.975;

param.planner_a   = [1,1];
param.planner_phi = 1;

%% SIMULATION PARAMETERS

param.theta      = 0.25;
param.theta_grid = (0:0.01:1.5)';

param.T     = 1600;
param.T_fig = 120;

%% PARSING INPUTS

p = inputParser;
p.CaseSensitive = true;
for f = fieldnames(param)'
    p.addParameter(f{:}, param.(f{:}));
end
parse(p, varargin{:});
param = p.Results;

%% DERIVED PARAMETERS

param.Pi = [param.rho, 1 - param.rho; 1 - param.rho,  param.rho];
param.S  = length(param.Pi);
param.I  = length(param.beta);

param.y  = param.y_bar + [param.eps, -param.eps]; % endowment
param.Ts = [-param.eps, param.eps];               % policy

fprintf('=================== Persistence (rho): %3.3f =================== \n\n',param.rho)

end