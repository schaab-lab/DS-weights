function fig_welfare(tau_grid,dW_det,Xi_AE_det,Xi_RD_det,Xi_RS_det,dW_rand,Xi_AE_rand,Xi_RD_rand,Xi_RS_rand,dV_lambda_det,dV_lambda_rand,tau_opt_det,tau_opt_rand,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);


    f1 = figure('Units','inches','Position',1.25*dimension);
    
    plot(tau_grid,dW_det,  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid,dV_lambda_det(:,1),'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid,dV_lambda_det(:,2),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(tau_grid,dV_lambda_det(:,1)+dV_lambda_det(:,2),'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;

    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\tau$ (tax rate)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Lifetime Welfare Gains: Deterministic Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\tau}$', '$\frac{dV^{1|\lambda}}{d\tau}$', '$\frac{dV^{2|\lambda}}{d\tau}$', '$\Xi^{E}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f2 = figure('Units','inches','Position',1.25*dimension);
    plot(tau_grid,dW_rand,  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid,dV_lambda_rand(:,1),'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid,dV_lambda_rand(:,2),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(tau_grid,dV_lambda_rand(:,1)+dV_lambda_rand(:,2),'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
     
    xlabel('$\tau$ (tax rate)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Lifetime Welfare Gains: Random Earnings','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\tau}$', '$\frac{dV^{1|\lambda}}{d\tau}$', '$\frac{dV^{2|\lambda}}{d\tau}$', '$\Xi^{E}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff

    f3 = figure('Units','inches','Position',1.25*dimension);
    
    plot(tau_grid,dW_det, 'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid, Xi_AE_det, 'Color','m','LineWidth',3,'LineStyle',style{2}); hold on;
    plot(tau_grid, Xi_RS_det, 'Color',color{4},'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(tau_grid, Xi_RD_det, 'Color','r','LineWidth',3,'LineStyle',style{2}); hold on;

    xline(tau_opt_det,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xlabel('$\tau$  (tax rate)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: Deterministic Earnings','interpreter','latex','FontSize',24,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\tau}$', ...
        '$\Xi^{AE}$',...
        '$\Xi^{RS}$',...
        '$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','NorthEast')
    legend boxoff
    
    f4 = figure('Units','inches','Position',1.25*dimension);

    plot(tau_grid,dW_rand, 'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(tau_grid, Xi_AE_rand, 'Color','m','LineWidth',3,'LineStyle',style{2}); hold on;
    plot(tau_grid, Xi_RS_rand, 'Color',color{4},'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(tau_grid, Xi_RD_rand, 'Color','r','LineWidth',3,'LineStyle',style{2}); hold on;

    xline(tau_opt_rand,'k','$\tau^*$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xlabel('$\tau$ (tax rate)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: Random Earnings','interpreter','latex','FontSize',24,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\tau}$', ...
        '$\Xi^{AE}$',...
        '$\Xi^{RS}$',...
        '$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','NorthEast')
    legend boxoff
        
    print(f1,'-depsc','-painters','-noui','-r600', [folder,'app2_welfare_decomp_i_det','.eps'])
    print(f2,'-depsc','-painters','-noui','-r600', [folder,'app2_welfare_decomp_i_rand','.eps'])
    print(f3,'-depsc','-painters','-noui','-r600', [folder,'app2_welfare_decomp_det','.eps'])
    print(f4,'-depsc','-painters','-noui','-r600', [folder,'app2_welfare_decomp_rand','.eps'])
    
    if optfig.close == 1; close(who('f')); end
end
end