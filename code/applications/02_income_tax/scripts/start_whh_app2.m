clear; clc; close all;

cd ..

% Add subfolders to path
addpath('figures','functions','output','scripts');

%% Figures

optfig.fontname     = 'Times New Roman';
optfig.dimension    = [0 0 8 6];
optfig.lw           = 2;
optfig.folder       = 'output\';
optfig.color        = num2cell(parula(7),2);
% optfig.color      = num2cell(jet(7),2);
optfig.style        = {'-','--',':','-.'};
optfig.marker       = {'none','o','x','s','+'};
optfig.markersize   = 10;

optfig.fontsize_tit = 24;
optfig.fontsize_ax  = 18;
optfig.fontsize_lab = 22;
optfig.fontsize_leg = 18;

optfig.plotfig = 1; % If 1, plots figures
optfig.close   = 0; % If 1, closes figures after plotting

optfig.tau_b = 0;
optfig.r = 0;

% disp(optfig)      % properties of plots

%% Timing
tic;
tic_start = tic;
