function fig_V_dV(b_bar_grid,b_unconstrained,V_i,dV_i,dV_lambda,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    

    f1 = figure('Units','inches','Position',2*dimension);

    subplot(2,2,1)
    plot(b_bar_grid,V_i(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^1(\overline{b})$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(2,2,2)
    plot(b_bar_grid,V_i(:,2),'Color',color{3},'LineWidth',lw,'LineStyle',style{1});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$V^2(\overline{b})$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    subplot(2,2,3)
    plot(b_bar_grid,dV_i(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid,dV_i(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^i}{d\overline{b}}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{dV^1}{d\overline{b}}$', '$\frac{dV^2}{d\overline{b}}$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff
    
    subplot(2,2,4)
    plot(b_bar_grid,dV_lambda(:,1),'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid,dV_lambda(:,2),'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^{i|\lambda}}{d\overline{b}}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{dV^{1|\lambda}}{d\overline{b}}$', '$\frac{dV^{2|\lambda}}{d\overline{b}}$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','Best')
    legend boxoff

    
    sgtitle('Comparative Statics','interpreter','latex','FontSize',24,'FontName',fontname);
    
    name_f1 = append('app3_V_dV','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])
    
    
    if optfig.close == 1; close(who('f')); end
end
end