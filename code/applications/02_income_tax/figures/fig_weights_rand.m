function fig_weights_rand(tau_grid,tau_opt_rand,omega_i,omega_s_L,omega_s_H,optfig)

% Computing sum of DS-Weights
omega_i_check   = (1/2)*(omega_i(:,1) + omega_i(:,2));
omega_s_1_check = omega_s_L(:,1) + omega_s_H(:,1);
omega_s_2_check = omega_s_L(:,2) + omega_s_H(:,2);


if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    

    f1 = figure('Units','inches','Position',[0 0 24 6]);
    
    subplot(1,3,1)
    plot(tau_grid,omega_i(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid,omega_i(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^i$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Individual Weights','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1$', '$\omega^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,2)
    plot(tau_grid,omega_s_L(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid,omega_s_L(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^i(L)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights $(s=L)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1(L)$', '$\omega^2(L)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(1,3,3)
    plot(tau_grid,omega_s_H(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid,omega_s_H(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^i(H)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights $(s=H)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1(H)$', '$\omega^2(H)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('DS-Weights: Random Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);

    f2 = figure('Units','inches','Position',1.25*dimension);

    plot(tau_grid,omega_i_check, 'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(tau_grid, omega_s_1_check, 'Color',color{4},'LineWidth',3,'LineStyle',style{3});
    plot(tau_grid, omega_s_2_check, 'Color','r','LineWidth',3,'LineStyle',style{3});

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('sum of DS-Weights: Random Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{1}{I}\sum\omega^i$',...
                  '$\sum_s\omega_1^1(s)$'...
                  '$\sum_s\omega_1^2(s)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff

    name_f1 = append('app2_DS_weights_rand','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])

    name_f2 = append('app2_DS_weights_rand_sum','.eps');
    print(f2,'-depsc','-painters','-noui','-r600',[folder,name_f2])
    
    
    if optfig.close == 1; close(who('f')); end
end
end