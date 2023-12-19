function fig_weights(b_bar_grid,b_unconstrained,omega_i,omega_0,omega_1,omega_s_L,omega_s_H,optfig)

% Computing sum of DS-Weights
omega_i_check   = (1/2)*(omega_i(:,1) + omega_i(:,2));
omega_1_check   = omega_0(:,1) + omega_1(:,1);
omega_2_check   = omega_0(:,2) + omega_1(:,2);
omega_s_1_check = omega_s_L(:,1) + omega_s_H(:,1);
omega_s_2_check = omega_s_L(:,2) + omega_s_H(:,2);

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    

    f1 = figure('Units','inches','Position',[0 0 16 24]);
    
    subplot(4,2,1)
    plot(b_bar_grid,omega_i(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^1$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Individual Weights for individual $1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(4,2,2)
    plot(b_bar_grid,omega_i(:,2),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega^2$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Individual Weights for individual $2$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(4,2,3)
    plot(b_bar_grid,omega_s_L(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_1^1(L)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights when $z=L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(4,2,4)
    plot(b_bar_grid,omega_s_L(:,2),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_1^2(L)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights when $z=L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(4,2,5)
    plot(b_bar_grid,omega_s_H(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_1^1(H)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights when $z=H$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(4,2,6)
    plot(b_bar_grid,omega_s_H(:,2),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_1^2(H)$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Stochastic Weights when $z=H$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    subplot(4,2,7)
    plot(b_bar_grid,omega_0(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid,omega_0(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_0^i$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Dynamic Weights at $t=0$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1_0$', '$\omega^2_0$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    subplot(4,2,8)
    plot(b_bar_grid,omega_1(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid,omega_1(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$\omega_1^i$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Dynamic Weights at $t=1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\omega^1_1$', '$\omega^2_1$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    sgtitle('DS-Weights','interpreter','latex','FontSize',24,'FontName',fontname);
    

    f2 = figure('Units','inches','Position',1.25*dimension);

    plot(b_bar_grid,omega_i_check, 'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(b_bar_grid, omega_1_check, 'Color',color{3}, 'LineWidth',3,'LineStyle',style{3});
    plot(b_bar_grid, omega_2_check, 'Color',color{6},'LineWidth',3,'LineStyle',style{4});
    plot(b_bar_grid, omega_s_1_check, 'Color',color{4},'LineWidth',3,'LineStyle',style{3});
    plot(b_bar_grid, omega_s_2_check, 'Color','r','LineWidth',3,'LineStyle',style{4});
    
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
   
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('sum of DS-Weights','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{1}{I}\sum_i\omega^i$',...
                  '$\sum_t\omega^1_t$',...
                  '$\sum_t\omega^2_t$'...
                  '$\sum_s\omega_1^1(s)$'...
                  '$\sum_s\omega_1^1(s)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff


    name_f1 = append('app3_DS_weights','.eps');
    name_f2 = append('app3_DS_weights_sum','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])
    print(f2,'-depsc','-painters','-noui','-r600',[folder,name_f2])
    
    
    if optfig.close == 1; close(who('f')); end
end
end