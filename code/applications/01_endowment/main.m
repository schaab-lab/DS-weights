% Application 1: Welfare Assessments with Heterogeneous Indviduals, ED/AS
% Convention: states in rows (L is first), agents in columns

run scripts/start_whh_app1.m; tic;

param = define_parameters('rho', 0.975);
fn_run_scenario(param, optfig)

param = define_parameters('rho', 0.5);
fn_run_scenario(param, optfig)

param = define_parameters('rho', 0.999);
fn_run_scenario(param, optfig)

grid_rho;

toc;