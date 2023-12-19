function fig_eq_rand(tau_grid,tau_opt_rand,c_opt_L_rand,c_opt_H_rand,n_opt_L_rand,n_opt_H_rand,V_opt_rand,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);

    f1 = figure('Units','inches','Position',[0 0 24 12]);

    subplot(2,3,1)
    plot(tau_grid, c_opt_L_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, c_opt_L_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i(L,\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption $(s=L)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1(L)$', '$c^2(L)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(2,3,2)
    plot(tau_grid, c_opt_H_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, c_opt_H_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i(H,\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption $(s=H)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1(H)$', '$c^2(H)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(2,3,3)
    plot(tau_grid, V_opt_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_opt_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$V^i(\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Indirect Utility','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$V^1$', '$V^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(2,3,4)
    plot(tau_grid, n_opt_L_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, n_opt_L_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$n^i(L,\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Labor Supply $(s=L)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$n^1(L)$', '$n^2(L)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(2,3,5)
    plot(tau_grid, n_opt_H_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, n_opt_H_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$n^i(H,\tau)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Labor Supply $(s=H)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$n^1(H)$', '$n^2(H)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('Comparative Statics: Random Earnings','interpreter','latex','FontSize',24,'FontName',fontname)

    name_f1 = append('app2_comparative_rand','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])
    
    
    if optfig.close == 1; close(who('f')); end
end
end