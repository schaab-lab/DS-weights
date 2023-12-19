function fig_agg(tau_grid,tau_opt,C_det,N_det,W_det,C_rand,N_rand,W_rand,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);

    f1 = figure('Units','inches','Position',[0 0 24 6]);

    subplot(1,3,1)
    plot(tau_grid, C_det,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, C_rand,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$C(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Deterministic Earnings', 'Random Earnings'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,2)
    plot(tau_grid, N_det,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, N_rand,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$N(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Labor Supply','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Deterministic Earnings', 'Random Earnings'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,3)
    plot(tau_grid, W_det,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, W_rand,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\mathcal{W}(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Deterministic Earnings', 'Random Earnings'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('Aggregates','interpreter','latex','FontSize',24,'FontName',fontname)

    name_f1 = append('app2_aggregates','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])
    
    
    if optfig.close == 1; close(who('f')); end
end
end