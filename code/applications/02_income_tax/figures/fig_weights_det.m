function fig_weights_det(tau_grid,tau_opt_det,omega_i,optfig)

% Computing sum of DS-Weights
omega_i_check   = (1/2)*(omega_i(:,1) + omega_i(:,2));

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    

    f1 = figure('Units','inches','Position',dimension*1.25);
    
    plot(tau_grid,omega_i(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(tau_grid,omega_i(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^i$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('DS-Weights: Deterministic Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1$', '$\omega^2$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    f2 = figure('Units','inches','Position',dimension*1.25);
    plot(tau_grid,omega_i_check, 'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    
    xlabel('$\tau$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('sum of DS-Weights: Deterministic Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{1}{I}\sum\omega^i$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff


    name_f1 = append('app2_DS_weights_det','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])

    name_f2 = append('app2_DS_weights_det_sum','.eps');
    print(f2,'-depsc','-painters','-noui','-r600',[folder,name_f2])
    
    
    if optfig.close == 1; close(who('f')); end
end
end