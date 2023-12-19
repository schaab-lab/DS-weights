function [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig)
% This function unpacks the structure optfig

fontname     = optfig.fontname;
dimension    = optfig.dimension;
lw           = optfig.lw;
folder       = optfig.folder;
color        = optfig.color;
style        = optfig.style;
marker       = optfig.marker;
markersize   = optfig.markersize;

fontsize_tit = optfig.fontsize_tit;
fontsize_ax  = optfig.fontsize_ax;
fontsize_lab = optfig.fontsize_lab;
fontsize_leg = optfig.fontsize_leg;

end
