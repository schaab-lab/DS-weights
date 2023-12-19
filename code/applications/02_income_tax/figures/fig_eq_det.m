function fig_eq_det(tau_grid,tau_opt_det,c_opt_det,n_opt_det,V_opt_det,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);

    f1 = figure('Units','inches','Position',[0 0 24 6]);

    subplot(1,3,1)
    plot(tau_grid, c_opt_det(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, c_opt_det(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1$', '$c^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,2)
    plot(tau_grid, n_opt_det(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, n_opt_det(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$n^i(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Labor Supply','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$n^1$', '$n^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,3)
    plot(tau_grid, V_opt_det(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_opt_det(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$V^i(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Indirect Utility','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$V^1$', '$V^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('Comparative Statics: Deterministic Earnings','interpreter','latex','FontSize',24,'FontName',fontname)

    name_f1 = append('app2_comparative_det','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])
    
    
    if optfig.close == 1; close(who('f')); end
end
end