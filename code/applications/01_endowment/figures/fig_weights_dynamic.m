function fig_weights_dynamic(omega_t_i,omega_t_i_ref,T_fig,indiv,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','Position',dimension);
    
    time = (0:1:T_fig)';
    line_L = omega_t_i(1,1:length(time));
    line_H = omega_t_i(2,1:length(time));
    
    plot(time,line_L,'Color',color{3},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,line_H,'Color',color{5},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,omega_t_i_ref(1,1:length(time)),'Color','k','LineWidth',1.5,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$t$ (time)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_{t}^{1}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    if indiv == '_02'
        ylabel('$\omega_{t}^{2}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    end
    title('Dynamic Weights','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    ylim([0,max(max(omega_t_i))])
    
    legendCell = {'$s_0 = L$', ...
        '$s_0 = H$',...
        '$(1-\beta) \beta^t$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    name = 'app1_dynamic_weight_ind';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,indiv,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end