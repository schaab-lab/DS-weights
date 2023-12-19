function fig_welfare(b_bar_grid,b_unconstrained,dW,dV_lambda,Xi_AE,Xi_RS,Xi_IS,Xi_RD,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);


    f1 = figure('Units','inches','Position',1.25*dimension);
    
    plot(b_bar_grid,dW,  'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(b_bar_grid,dV_lambda(:,1),'Color',color{1},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(b_bar_grid,dV_lambda(:,2),'Color',color{5},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(b_bar_grid,dV_lambda(:,1)+dV_lambda(:,2),'Color',color{3},'LineWidth',3,'LineStyle',style{4}); hold on;
    
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xlabel('$\overline{b}$ (borrowing limit)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Lifetime Welfare Gains','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW^{\lambda}}{d\overline{b}}$', '$\frac{dV^{1|\lambda}}{d\overline{b}}$', '$\frac{dV^{2|\lambda}}{d\overline{b}}$', '$\Xi^{E}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f2 = figure('Units','inches','Position',1.25*dimension);

    plot(b_bar_grid,dW, 'Color',color{6},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(b_bar_grid, Xi_AE, 'Color','m','LineWidth',3,'LineStyle',style{2}); hold on;
    plot(b_bar_grid, Xi_RS, 'Color',color{4},'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(b_bar_grid, Xi_IS, 'Color',color{1}, 'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(b_bar_grid, Xi_RD, 'Color','r','LineWidth',3,'LineStyle',style{2}); hold on;

    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)

    xlabel('$\overline{b}$ (borrowing limit)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Welfare Decomposition','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$\frac{dW^{\lambda}}{d\overline{b}}$', '$\Xi^{AE}$','$\Xi^{RS}$','$\Xi^{IS}$', '$\Xi^{RD}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff

    name = 'app3_welfare_decomp_i';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])

    name = 'app3_welfare_decomp';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])

    if optfig.close == 1; close(who('f')); end
    
end

end