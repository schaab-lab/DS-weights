function fig_c_theta(theta_grid,c,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','Position',dimension);
    
    plot(theta_grid,squeeze(c(1,1,:)),'Color',color{3},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(c(1,2,:)),'Color',color{5},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(c(2,1,:)),'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,squeeze(c(2,2,:)),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i(s)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$c^1(s=L)$', '$c^2(s=L)$', '$c^1(s=H)$', '$c^2(s=H)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    rho  = strrep(num2str(rho),'.',''); % For saving persistence
    name = 'app1_consumption';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end