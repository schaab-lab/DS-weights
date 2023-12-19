%% PLOT: Figure 4: Aggregate additive decomposition of welfare assessments (Scenario 1)
[vec_AE, vec_RS, vec_IS, vec_RE] = deal(zeros(param.num_theta, length(param.phi)));
vec_theta = zeros(param.num_theta,1);
for i = 1:param.num_phi
    for j = 1:param.num_theta
        vec_theta(j) = CE{j}.theta;
        vec_AE(j,i) = AE{j,i};
        vec_RS(j,i) = RS{j,i};
        vec_IS(j,i) = IS{j,i};
        vec_RE(j,i) = RE{j,i};
    end
end

figure; hold on;
l1 = plot(vec_theta, vec_AE(:,1)+vec_RS(:,1)+vec_IS(:,1)+vec_RE(:,1),'color',[255,188,000]./255);
l2 = plot(vec_theta, vec_AE(:,1),'m--');
l3 = plot(vec_theta, vec_RS(:,1),'c:');
l4 = plot(vec_theta, vec_IS(:,1),'-.','color',[000,076,153]./255);
l5 = plot(vec_theta, vec_RE(:,1),'--','color',[202,091,035]./255);
l6 = xline(1,'k--','$\theta^*$','LineWidth',1.5,'Interpreter','Latex','Fontsize',18); l6.LabelVerticalAlignment = 'bottom';
hold off;
xlabel('$\theta$ (policy)','Interpreter','Latex','Fontsize',16);
title('Marginal Welfare Assessments','Interpreter','Latex','Fontsize',16);
txt = ['$\lambda$ = ' num2str(round(param.la1,3))];
text(0.1,-0.015,txt,'Interpreter', 'Latex','Fontsize',14)
legend([l1, l2, l3, l4, l5], ...
    {'$\frac{dW}{d\theta}$','$\Xi_{AE}$ (Agg. Efficiency)', '$\Xi_{RS}$ (Risk-Sharing)', '$\Xi_{IS}$ (Inter.-Sharing)', '$\Xi_{RD}$ (Redistribution)'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast')

exportgraphics(gcf, ['./output/replicate_fig4-',num2str(round(param.la1,3)),'.eps']);

%% PLOT: Figure 5: Aggregate additive decomposition; comparison of welfarist planners (Scenario 1)

figure; hold on;
l1 = plot(vec_theta, vec_AE(:,1) + vec_RS(:,1) +  vec_IS(:,1) + vec_RE(:,1),'color',[255,188,000]./255);
l2 = plot(vec_theta, vec_AE(:,2) + vec_RS(:,2) +  vec_IS(:,2) + vec_RE(:,2),'--','color',[000,205,108]./255);
l3 = plot(vec_theta, vec_AE(:,3) + vec_RS(:,3) +  vec_IS(:,3) + vec_RE(:,3),':','color',[0.3010 0.7450 0.9330]);
%l4 = xline(1,'k--','$\theta^*$','LineWidth',1.5,'Interpreter','Latex','Fontsize',18); l4.LabelVerticalAlignment = 'bottom';
hold off;
xlabel('$\theta$ (policy)','Interpreter','Latex','Fontsize',16);
title('Welfarist Assessments (varying SWF)','Interpreter','Latex','Fontsize',16);
legend([l1, l2, l3], ...
    {'$\frac{dW}{d\theta}, \phi=1$', '$\frac{dW}{d\theta}, \phi=5$', '$\frac{dW}{d\theta}, \phi=10$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',16)
exportgraphics(gcf, ['./output/replicate_fig51-',num2str(round(param.la1,3)),'.eps']);


figure; hold on;
l1 = plot(vec_theta, vec_RE(:,1),'color',[255,188,000]./255);
l2 = plot(vec_theta, vec_RE(:,2),'--','color',[000,205,108]./255);
l3 = plot(vec_theta, vec_RE(:,3),':','color',[0.3010 0.7450 0.9330]);
l4 = plot(vec_theta, vec_RS(:,1) +  vec_IS(:,1),'-.','color',[000,076,153]./255);
%l4 = xline(1,'k--','$\theta^*$','LineWidth',1.5,'Interpreter','Latex','Fontsize',18); l4.LabelVerticalAlignment = 'bottom';
hold off;
xlabel('$\theta$ (policy)','Interpreter','Latex','Fontsize',16);
title('Redistribution Component (varying SWF)','Interpreter','Latex','Fontsize',16);
legend([l1, l2, l3, l4], ...
    {'$\Xi_{RD}, \phi=1$', '$\Xi_{RD}, \phi=5$', '$\Xi_{RD}, \phi=10$', '$\Xi_{RS} = \Xi_{IS}$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',16)

exportgraphics(gcf, ['./output/replicate_fig52-',num2str(round(param.la1,3)),'.eps']);


%% PLOT: Figure 3, Figure OA-1 or Figure OA-2: Individual multiplicative decomposition of DS-weights (Scenario 1)

theta = 0.25;
[~, j] = min(abs(theta - vec_theta));
[plot_omega_sto, plot_omega] = deal(zeros(param.N, 2*2));
for n = 1:param.N
    plot_omega_sto(n,1) = omega_sto{j,1}{n}(1,1);
    plot_omega_sto(n,2) = omega_sto{j,1}{n}(2,1);
    plot_omega_sto(n,3) = omega_sto{j,1}{n}(1,2); 
    plot_omega_sto(n,4) = omega_sto{j,1}{n}(2,2);
    
    plot_omega(n,1) = omega_sto{j,1}{n}(1,1) * omega_dyn{j,1}(1,n) * omega_ind{j,1}(1);
    plot_omega(n,2) = omega_sto{j,1}{n}(2,1) * omega_dyn{j,1}(1,n) * omega_ind{j,1}(1);
    plot_omega(n,3) = omega_sto{j,1}{n}(1,2) * omega_dyn{j,1}(2,n) * omega_ind{j,1}(2);
    plot_omega(n,4) = omega_sto{j,1}{n}(2,2) * omega_dyn{j,1}(2,n) * omega_ind{j,1}(2);
end

figure; hold on;
set(gcf,'position',[440 387 800 250])
subplot(1,3,1)
l10 = plot(param.t, param.rho*exp(-param.rho*param.t),'k--','LineWidth',2); hold on;
l11 = plot(param.t, 4.*omega_dyn{j,1}(1,:)','color',[000,076,153]./255,'LineWidth',2); hold on;
l12 = plot(param.t, 4.*omega_dyn{j,1}(2,:)','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}(t|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Dynamic Component','Interpreter','Latex','Fontsize',16);
legend([l10, l11, l12,], ...
    {'$\rho e^{-\rho t}$', '$z = L$', '$z=H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(1,3,2)
l21 = plot(param.t, plot_omega_sto(:,1),'color',[000,076,153]./255,'LineWidth',2); hold on;
l22 = plot(param.t, plot_omega_sto(:,2),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l23 = plot(param.t, plot_omega_sto(:,3),'color',[064,173,090]./255,'LineWidth',2); hold on;
l24 = plot(param.t, plot_omega_sto(:,4),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Stochastic Component','Interpreter','Latex','Fontsize',16);
legend([l21, l22, l23, l24], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(1,3,3)
l31 = plot(param.t, 4.*plot_omega(:,1),'color',[000,076,153]./255,'LineWidth',2); hold on;
l32 = plot(param.t, 4.*plot_omega(:,2),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l33 = plot(param.t, 4.*plot_omega(:,3),'color',[064,173,090]./255,'LineWidth',2); hold on;
l34 = plot(param.t, 4.*plot_omega(:,4),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('${\omega}(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('DS-weights','Interpreter','Latex','Fontsize',16);
legend([l31, l32, l33, l34], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

exportgraphics(gcf, ['./output/replicate_figOA-',num2str(round(param.la1,3)),'.eps']);
