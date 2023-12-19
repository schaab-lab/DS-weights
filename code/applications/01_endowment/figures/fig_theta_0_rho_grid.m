function fig_theta_0_rho_grid(rho,dW,Xi_AE,Xi_RS,Xi_IS,Xi_RD,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    
    f1 = figure('Units','inches','Position',1.25*dimension);
    
    plot(rho,dW(1,:),  'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(rho,Xi_AE(1,:),'Color','m', 'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(rho,Xi_RS(1,:),'Color',color{4}, 'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(rho,Xi_IS(1,:),'Color',color{1}, 'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(rho,Xi_RD(1,:),'Color','r', 'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\rho$ (persistence)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: $s_0 = L$ and $\theta=0$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta} $', '$\Xi^{AE}$', '$\Xi^{RS}$', '$\Xi^{IS}$','$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff

    f2 = figure('Units','inches','Position',1.25*dimension);
    
    plot(rho,dW(2,:),  'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(rho,Xi_AE(2,:),'Color','m', 'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(rho,Xi_RS(2,:),'Color',color{4}, 'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(rho,Xi_IS(2,:),'Color',color{1}, 'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(rho,Xi_RD(2,:),'Color','r', 'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\rho$ (persistence)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition: $s_0 = H$ and $\theta=0$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\theta} $', '$\Xi^{AE}$', '$\Xi^{RS}$', '$\Xi^{IS}$','$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff

    name = 'app1_welfare_decomp_rho_grid_s0_L_theta_0';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])

    name = 'app1_welfare_decomp_rho_grid_s0_H_theta_0';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])
end
end
    