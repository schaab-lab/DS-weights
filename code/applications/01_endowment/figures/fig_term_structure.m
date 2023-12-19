function fig_term_structure(TS,dV_lambda_t,omega_t,T_fig,rho,optfig)

if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,fontsize_ax,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    time  = (0:1:T_fig)';
    
    f1 = figure('Units','inches','Position',dimension);
    plot(time,TS.Xi_RS(1,1:length(time))./TS.omega_t(1,1:length(time)) + TS.Xi_IS(1,1:length(time))./TS.omega_t(1,1:length(time)) + TS.Xi_RD(1,1:length(time))./TS.omega_t(1,1:length(time)), ...
        'Color',color{6}, 'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,TS.Xi_RS(1,1:length(time))./TS.omega_t(1,1:length(time)),'Color',color{4},'LineWidth',3,'LineStyle',style{3}); hold on;
    plot(time,TS.Xi_IS(1,1:length(time))./TS.omega_t(1,1:length(time)),'Color',color{1},'LineWidth',3,'LineStyle',style{4}); hold on;
    plot(time,TS.Xi_RD(1,1:length(time))./TS.omega_t(1,1:length(time)),'Color','r',     'LineWidth',3,'LineStyle',style{2}); hold on;
    yline(0,'--k','LineWidth',1.25)
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$t$ (time)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Term Structure: $s_0 = L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{dW_{t}^{\lambda}}{d\theta}$','$\Xi^{RS}_t$','$\Xi^{IS}_t$','$\Xi^{RD}_t$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f2 = figure('Units','inches','Position',[0,0,16,6]);
    
    subplot(1,2,1)
    plot(time,(squeeze(omega_t(1,1:length(time),1)).*squeeze(dV_lambda_t(1,1:length(time),1)))./TS.omega_t(1,1:length(time)),'Color',color{2},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,(squeeze(omega_t(1,1:length(time),2)).*squeeze(dV_lambda_t(1,1:length(time),2)))./TS.omega_t(1,1:length(time)),'Color',color{6},'LineWidth',3,'LineStyle',style{2}); hold on;
    yline(0,'--k','LineWidth',1.25)
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$t$ (time)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{\omega^i_t}{\omega_t}\frac{dV^{i|\lambda}_t}{d\theta}: s_0=L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$i=1$','$i=2$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    subplot(1,2,2)
    plot(time,squeeze(dV_lambda_t(1,1:length(time),1)),'Color',color{2},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time,squeeze(dV_lambda_t(1,1:length(time),2)),'Color',color{6},'LineWidth',3,'LineStyle',style{2}); hold on;
    yline(0,'--k','LineWidth',1.25)
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$t$ (time)','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$\frac{dV^{i|\lambda}_t}{d\theta}: s_0=L$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$i=1$','$i=2$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f3 = figure('Units','inches','Position',[0,0,16,6]);
    
    [transition,SS,transition_Tstar,SS_Tstar] = fn_SS(TS);
    
    subplot(1,2,1)
    plot(time(1:30),transition(1:30),'Color',color{2},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(time(1:30),SS(1:30),'Color',color{6},'LineWidth',3,'LineStyle',style{2}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$T^{\star}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Date 0','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\sum_{t=0}^{T^{\star}}\omega_t\frac{dW_{t}^{\lambda}}{d\theta}$',...
        '$\sum_{t=T^{\star}}^{T}\omega_t\frac{dW_{t}^{\lambda}}{d\theta}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    subplot(1,2,2)
    
    plot(time(1:30),SS_Tstar(1:30),'Color',color{6},'LineWidth',3,'LineStyle',style{2}); hold on;
    plot(time(1:30),transition_Tstar(1:30),'Color',color{2},'LineWidth',3,'LineStyle',style{1}); hold on;
    
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName',fontname,'fontsize',fontsize_ax)
    
    xlabel('$T^{\star}$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$T^{\star}$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$\frac{\sum_{t=T^{\star}}^{T}\omega_t\frac{dW_{t}^{\lambda}\left(s_{0}\right)}{d\theta}}{\sum_{t=T^{\star}}^{T}\omega_t}$',...
        '$\frac{\sum_{t=0}^{T}\omega_t\frac{dW_{t}^{\lambda}\left(s_{0}\right)}{d\theta}}{\sum_{t=T^{\star}}^{T}\omega_t}$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    rho  = strrep(num2str(rho),'.',''); % For saving persistence
    name = 'app1_term_structure';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    name = 'app1_term_structure_weights';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    name = 'app1_term_structure_transition';
    print(f3,'-depsc','-painters','-noui','-r600', [folder,name,'_rho_',rho,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end