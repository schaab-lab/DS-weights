function fig_welfare(theta_grid, W_grid,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','Position',dimension);

    plot(theta_grid,W_grid(1,:),  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,W_grid(2,:),'Color',color{1},'LineWidth',3,'LineStyle',style{2}); hold off;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$W(s_0;\theta)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$W(s_L)$', '$W(s_H)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    rho       = strrep(num2str(rho),'.',''); % For saving persistence
    name = 'app1_welfare_total';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end