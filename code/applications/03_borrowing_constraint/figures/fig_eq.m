function fig_eq(b_bar_grid,b_opt,k0_opt,c0_opt_1,c0_opt_2,c1_opt_1,c1_opt_2,q0_opt,b_unconstrained,optfig)

if optfig.plotfig == 1
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);


    % Illustration of impatient agent's borrowing
    f1 = figure('Units','inches','Position',[0 0 15 6]);

    subplot(1,2,1)
    plot(b_bar_grid,b_opt(:,1),'Color',color{6},'LineWidth',lw,'LineStyle',style{1}); hold on;

    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$b^1_0(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Borrowing','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(1,2,2)
    plot(b_bar_grid,k0_opt,'Color',color{6},'LineWidth',lw,'LineStyle',style{1}); hold on;

    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$k_0^1(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Investment','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    sgtitle('Investor Behavior','interpreter','latex','FontSize',24,'FontName',fontname)

    % Summary of comaprative statics
    f2 = figure('Units','inches','Position',[0 0 20 22.5]);

    subplot(2,3,1)
    plot(b_bar_grid, b_opt(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid, b_opt(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$b^i_0(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Borrowing','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$b^1_0$', '$b^2_1$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','SouthWest')
    legend boxoff

    subplot(2,3,2)
    plot(b_bar_grid, k0_opt(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$k_0^1(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Investment','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    subplot(2,3,3)
    plot(b_bar_grid, q0_opt(:),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$q_0(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Price','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    subplot(2,3,4)
    plot(b_bar_grid, c0_opt_1,  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid, c0_opt_2,  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i_0(\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption at $t=0$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1_0$', '$c^2_0$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','SouthWest')
    legend boxoff

    subplot(2,3,5)
    plot(b_bar_grid, c1_opt_1(:,1),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid, c1_opt_2(:,1),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i_1(L,\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption at $t=1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1_1(L)$', '$c^2_1(L)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','West')
    legend boxoff

    subplot(2,3,6)
    plot(b_bar_grid, c1_opt_1(:,2),  'Color',color{3},'LineWidth',lw,'LineStyle',style{1}); hold on;
    plot(b_bar_grid, c1_opt_2(:,2),  'Color',color{4},'LineWidth',lw,'LineStyle',style{2});
    xline(b_unconstrained(1),'k','$b^{u}$','LineWidth',2,'LineStyle',style{2},...
            'LabelOrientation','horizontal','LabelVerticalAlignment','bottom',...
            'interpreter','latex','FontSize',fontsize_lab,'FontName',fontname)
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    xlabel('$\overline{b}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    ylabel('$c^i_1(L,\overline{b})$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Consumption at $t=1$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;

    legendCell = {'$c^1_1(H)$', '$c^2_1(H)$'};
    legend(legendCell,'interpreter','latex','FontSize',fontsize_leg,'FontName',fontname,'Location','West')
    legend boxoff

    sgtitle('Comparative Statics','interpreter','latex','FontSize',24,'FontName',fontname)

    name_f1 = append('app3_investor','.eps');
    print(f1,'-depsc','-painters','-noui','-r600',[folder,name_f1])

    name_f2 = append('app3_comparative','.eps');
    print(f2,'-depsc','-painters','-noui','-r600',[folder,name_f2])
    
    
    if optfig.close == 1; close(who('f')); end
end
end