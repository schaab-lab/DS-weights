function fig_weights_stochastic(omega_s_i,T_fig,indiv,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','Position',dimension);
    
    time = (0:1:T_fig)';
    line_L_to_L = squeeze(omega_s_i(1,1,1:length(time)));
    line_L_to_H = squeeze(omega_s_i(1,2,1:length(time)));
    line_H_to_L = squeeze(omega_s_i(2,1,1:length(time)));
    line_H_to_H = squeeze(omega_s_i(2,2,1:length(time)));
    
    plot(time,line_L_to_L,'Color',color{3},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,line_L_to_H,'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(time,line_H_to_L,'Color',color{5},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,line_H_to_H,'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$t$ (time)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_{t}^{1}\left(s^{t}\right)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    if indiv == '_02'
        ylabel('$\omega_{t}^{2}\left(s^{t}\right)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    end
    title('Stochastic Weights','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$s_0 = L$, $s_t = L$', ...
        '$s_0 = L$, $s_t = H$',...
        '$s_0 = H$, $s_t = L$',...
        '$s_0 = H$, $s_t = H$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    name = 'app1_stochastic_weight_ind';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,indiv,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end