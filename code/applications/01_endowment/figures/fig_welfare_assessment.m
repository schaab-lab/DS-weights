function fig_welfare_assessment(theta_grid,dV_lambda,dW,Xi_AE,Xi_RS,Xi_IS,Xi_RD,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f_dW_1      = @(x) interp1(theta_grid,dW(1,:),x);
    f_dW_2      = @(x) interp1(theta_grid,dW(2,:),x);
    theta_opt_1 = fzero(f_dW_1,mean(theta_grid));
    theta_opt_2 = fzero(f_dW_2,mean(theta_grid));
    fprintf('theta_opt_1 = %4.4f \n', theta_opt_1)
    fprintf('theta_opt_2 = %4.4f \n\n', theta_opt_2)
    
    f1 = figure('Units','inches','Position',1.25*dimension);
    
    plot(theta_grid,dW(1,:),  'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,Xi_AE(1,:),'Color','m', 'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,Xi_RS(1,:),'Color',color{4}, 'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(theta_grid,Xi_IS(1,:),'Color',color{1}, 'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(theta_grid,Xi_RD(1,:),'Color','r', 'LineWidth',3,'LineStyle',style{2}); hold on;
    if ~isnan(theta_opt_1)
        xline(theta_opt_1,'k','$\theta^{\star}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    end
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: $s_0 = L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta} $', '$\Xi^{AE}$', '$\Xi^{RS}$', '$\Xi^{IS}$','$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','NorthEast')
    legend boxoff
    
    text(0.1,-0.03,'$\rho=$' + "" + string(rho),'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    
    f2 = figure('Units','inches','Position',1.25*dimension);
    
    plot(theta_grid,dW(2,:),  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,Xi_AE(2,:),'Color','m','LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,Xi_RS(2,:),'Color',color{4},'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(theta_grid,Xi_IS(2,:),'Color',color{1},'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(theta_grid,Xi_RD(2,:),'Color','r','LineWidth',3,'LineStyle',style{2}); hold on;
    if ~isnan(theta_opt_2)
        xline(theta_opt_2,'k','$\theta^{\star}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    end
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: $s_0 = H$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta} $', '$\Xi^{AE}$', '$\Xi^{RS}$', '$\Xi^{IS}$','$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','NorthEast')
    legend boxoff
    
    text(0.1,-0.03,'$\rho=$' + "" + string(rho),'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
       
    f3 = figure('Units','inches','Position',1.25*dimension);
    
    plot(theta_grid,dW(1,:),  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(dV_lambda(1,1,:)),'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(dV_lambda(1,2,:)),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,squeeze(dV_lambda(1,1,:))+squeeze(dV_lambda(1,2,:)),'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Lifetime Welfare Gains: $s_0 = L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta}$', '$\frac{dV^{1|\lambda}}{d\theta}$', '$\frac{dV^{2|\lambda}}{d\theta}$', '$\Xi^E$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f4 = figure('Units','inches','Position',1.25*dimension);

    plot(theta_grid,dW(2,:),  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(dV_lambda(2,1,:)),'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,squeeze(dV_lambda(2,2,:)),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,squeeze(dV_lambda(2,1,:))+squeeze(dV_lambda(2,2,:)),'Color',color{3},'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Lifetime Welfare Gains: $s_0 = H$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta}$', '$\frac{dV^{1|\lambda}}{d\theta}$', '$\frac{dV^{2|\lambda}}{d\theta}$', '$\Xi^E$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    rho       = strrep(num2str(rho),'.',''); % For saving persistence
    name = 'app1_welfare_decomp_s0_L';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    name = 'app1_welfare_decomp_s0_H';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    name = 'app1_welfare_decomp_i_s0_L';
    print(f3,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    name = 'app1_welfare_decomp_i_s0_H';
    print(f4,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end