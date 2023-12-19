function fig_numerical_test(tau_grid,W_det,W_rand,W_numerical_det,W_numerical_rand,dW_analytical_det,dW_analytical_rand,dW_numerical_det,dW_numerical_rand,...
    V_det,V_numerical_det,V_rand,V_numerical_rand,dV_det,dV_numerical_det,dV_rand,dV_numerical_rand,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);

    f1 = figure('Units','inches','Position',[0 0 12 12]);

    subplot(3,2,1)
    plot(tau_grid, V_det(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_numerical_det(:,1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,2)
    plot(tau_grid, V_det(:,2),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_numerical_det(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^2$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,3)
    plot(tau_grid(1:length(tau_grid)-1), dV_det(1:length(tau_grid)-1,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dV_numerical_det(1:length(tau_grid)-1,1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^1}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,4)
    plot(tau_grid(1:length(tau_grid)-1), dV_det(1:length(tau_grid)-1,2),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dV_numerical_det(1:length(tau_grid)-1,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^2}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,5)
    plot(tau_grid, W_det,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, W_numerical_det,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\mathcal{W}(\tau)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,6)
    plot(tau_grid(1:length(tau_grid)-1), dW_analytical_det(1:length(tau_grid)-1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dW_numerical_det(1:length(tau_grid)-1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{d\mathcal{W}}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('Analytical vs Numerical: Deterministic Earnings','interpreter','latex','FontSize',24,'FontName',fontname)

    f2 = figure('Units','inches','Position',[0 0 12 12]);

    subplot(3,2,1)
    plot(tau_grid, V_rand(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_numerical_rand(:,1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,2)
    plot(tau_grid, V_rand(:,2),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, V_numerical_rand(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^2$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,3)
    plot(tau_grid(1:length(tau_grid)-1), dV_rand(1:length(tau_grid)-1,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dV_numerical_rand(1:length(tau_grid)-1,1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^1}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,4)
    plot(tau_grid(1:length(tau_grid)-1), dV_rand(1:length(tau_grid)-1,2),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dV_numerical_rand(1:length(tau_grid)-1,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^2}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,5)
    plot(tau_grid, W_rand,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid, W_numerical_rand,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\mathcal{W}(\tau)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(3,2,6)
    plot(tau_grid(1:length(tau_grid)-1), dW_analytical_rand(1:length(tau_grid)-1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid(1:length(tau_grid)-1), dW_numerical_rand(1:length(tau_grid)-1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{d\mathcal{W}}{d\tau}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'Analytical', 'Numerical'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('Analytical vs Numerical: Random Earnings','interpreter','latex','FontSize',24,'FontName',fontname)

    name_f1 = append('app2_numerical_test_det','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])

    name_f2 = append('app2_numerical_test_rand','.eps');
    print(f2,'-depsc','-painters','-noui','-r600',[folder,name_f2])
    
    
    if optfig.close == 1; close(who('f')); end
end
end