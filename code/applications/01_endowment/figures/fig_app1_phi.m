function fig_app1_phi(phi_grid,theta_grid,dW,Xi_RS,Xi_IS,Xi_RD,omega_i_phi,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','Position',dimension);
    
    plot(theta_grid,dW(1,:,1),'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,dW(1,:,2),'Color',color{5}, 'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,dW(1,:,3),'Color',color{3}, 'LineWidth',3,'LineStyle',style{3}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfarist Assessments (varying SWF)','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = "$\frac{dW^{\lambda}}{d\theta}, \phi = $" + "" + string(phi_grid);
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',optfig.fontname,'Location','Best')
    legend boxoff
    
    f2 = figure('Units','inches','Position',dimension);
    
    plot(theta_grid,Xi_RD(1,:,1),'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(theta_grid,Xi_RD(1,:,2),'Color',color{5}, 'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(theta_grid,Xi_RD(1,:,3),'Color',color{3}, 'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(theta_grid,Xi_RS(1,:,1) + Xi_IS(1,:,1),'Color',color{1}, 'LineWidth',3,'LineStyle',style{4}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Redistribution (varying SWF)','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = "$\Xi^{RD}, \phi = $" + string(phi_grid);
    legendCell{4} = '$\Xi^{RS} + \Xi^{IS}$';
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',optfig.fontname,'Location','Best')
    legend boxoff
    
    f3 = figure('Units','inches','Position',dimension);
    
    subplot(1,2,1)
    plot(theta_grid,squeeze(omega_i_phi(1,1,:,1)),'LineWidth',3); hold on;
    plot(theta_grid,squeeze(omega_i_phi(1,1,:,2)),'LineWidth',3); hold on;
    plot(theta_grid,squeeze(omega_i_phi(1,1,:,3)),'LineWidth',3); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\omega^1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = "$\phi = $" + string(phi_grid);
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',optfig.fontname,'Location','Best')
    legend boxoff
    
    subplot(1,2,2)
    plot(theta_grid,squeeze(omega_i_phi(1,2,:,1)),'LineWidth',3); hold on;
    plot(theta_grid,squeeze(omega_i_phi(1,2,:,2)),'LineWidth',3); hold on;
    plot(theta_grid,squeeze(omega_i_phi(1,2,:,3)),'LineWidth',3); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$\theta$ (policy)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\omega^2$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = "$\phi = $" + string(phi_grid);
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',optfig.fontname,'Location','Best')
    legend boxoff
    
    sgtitle('Individual Weights','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    
    rho       = strrep(num2str(rho),'.',''); % For saving persistence
    name = 'app1_SWF';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    name = 'app1_SWF_RD';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end