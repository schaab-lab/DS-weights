%% SAVE WEIGHTS DEPENDENT ON INITIAL DISTRIBUTION
vec_theta = zeros(param.num_theta,1);
for  i = 1:param.num_phi
    for j = 1:param.num_theta
        vec_theta(j) = CE{j}.theta;
    end
end

theta = 0.25; % figures in the paper are done with θ = 0.25
[~, j] = min(abs(theta - vec_theta));
plot_omega_dyn = zeros(param.N, 2, param.num_indiv);
[plot_omega_sto, plot_omega] = deal(zeros(param.N, 2*2, param.num_indiv));

for n = 1:param.N
    for i = 1:param.num_indiv
        plot_omega_dyn(n,1,i) = omega_dyn{j,1,i}(1,n);
        plot_omega_dyn(n,2,i) = omega_dyn{j,1,i}(2,n);

        plot_omega_sto(n,1,i) = omega_sto{j,1,i}{n}(1,1);
        plot_omega_sto(n,2,i) = omega_sto{j,1,i}{n}(1,2);
        plot_omega_sto(n,3,i) = omega_sto{j,1,i}{n}(2,1);        
        plot_omega_sto(n,4,i) = omega_sto{j,1,i}{n}(2,2);

        plot_omega(n,1,i) = omega_sto{j,1,i}{n}(1,1) * omega_dyn{j,1,i}(1,n) * omega_ind{j,1,i}(1);
        plot_omega(n,2,i) = omega_sto{j,1,i}{n}(1,2) * omega_dyn{j,1,i}(1,n) * omega_ind{j,1,i}(1);
 
        plot_omega(n,3,i) = omega_sto{j,1,i}{n}(2,1) * omega_dyn{j,1,i}(2,n) * omega_ind{j,1,i}(2);
        plot_omega(n,4,i) = omega_sto{j,1,i}{n}(2,2) * omega_dyn{j,1,i}(2,n) * omega_ind{j,1,i}(2);

    end
end

%% PLOTS: Figure 8: Aggregate additive decomposition of welfare assessments (Scenario 2)
for z = 1:param.num_agg

    [~, j] = min(abs(vec_AE{z}(:,1)+vec_RS{z}(:,1)+vec_IS{z}(:,1)+vec_RE{z}(:,1)));
    theta_star = vec_theta(j);

    figure; hold on;
    l1 = plot(vec_theta', vec_AE{z}(:,1)+vec_RS{z}(:,1)+vec_IS{z}(:,1)+vec_RE{z}(:,1),'color',[255,188,000]./255);
    l2 = plot(vec_theta', vec_AE{z}(:,1),'m--');
    l3 = plot(vec_theta', vec_RS{z}(:,1),'c:');
    l4 = plot(vec_theta', vec_IS{z}(:,1),'-.','color',[000,076,153]./255);
    l5 = plot(vec_theta', vec_RE{z}(:,1),'--','color',[202,091,035]./255);
    l6 = xline(theta_star,'k--','$\theta^*$','LineWidth',1.5,'Interpreter','Latex','Fontsize',18); l6.LabelVerticalAlignment = 'bottom';
    hold off;
    xlabel('$\theta$ (policy)','Interpreter','Latex','Fontsize',16);
    
    if z == 1
        title('Marginal Welfare Assessments: $z = L$','Interpreter','Latex','Fontsize',16);
    elseif z == 2
        title('Marginal Welfare Assessments: $z = H$','Interpreter','Latex','Fontsize',16);
    else
        title('Marginal Welfare Assessments','Interpreter','Latex','Fontsize',16);
    end

    txt = ['$\lambda$ = ' num2str(round(param.la1,3))];
    text(0.1,-0.015,txt,'Interpreter', 'Latex','Fontsize',14)
    legend([l1, l2, l3, l4, l5], ...
        {'$\frac{dW}{d\theta}$','$\Xi_{AE}$ (Agg. Efficiency)', '$\Xi_{RS}$ (Risk-Sharing)', '$\Xi_{IS}$ (Inter.-Sharing)', '$\Xi_{RD}$ (Redistribution)'}, ...
        'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast')

    exportgraphics(gcf, ['./output/replicate_fig8-',num2str(z),'-',num2str(round(param.la1,3)),'.eps']);
end

%% Figure 7: Individual multiplicative decomposition of DS-weights (Scenario 2)
figure; hold on;
set(gcf,'position',[440 387 800 450])

subplot(2,3,1)
l10 = plot(param.t, param.rho*exp(-param.rho*param.t),'k--','LineWidth',2); hold on;
l11 = plot(param.t, 2*plot_omega_dyn(:,1,1),'color',[000,076,153]./255,'LineWidth',2); hold on;
l12 = plot(param.t, 2*plot_omega_dyn(:,2,1),'color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}^1(t|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Dynamic Component','Interpreter','Latex','Fontsize',16);
legend([l10, l11, l12,], ...
    {'$\rho e^{-\rho t}$', '$z = L$', '$z=H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(2,3,2)
l21 = plot(param.t, 2*plot_omega_sto(:,1,1),'color',[000,076,153]./255,'LineWidth',2); hold on;
l22 = plot(param.t, 2*plot_omega_sto(:,2,1),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l23 = plot(param.t, 2*plot_omega_sto(:,3,1),'color',[064,173,090]./255,'LineWidth',2); hold on;
l24 = plot(param.t, 2*plot_omega_sto(:,4,1),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}^1(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Stochastic Component','Interpreter','Latex','Fontsize',16);
legend([l21, l22, l23, l24], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(2,3,3)
l31 = plot(param.t, 2*2*plot_omega(:,1,1),'color',[000,076,153]./255,'LineWidth',2); hold on;
l32 = plot(param.t, 2*2*plot_omega(:,2,1),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l33 = plot(param.t, 2*2*plot_omega(:,3,1),'color',[064,173,090]./255,'LineWidth',2); hold on;
l34 = plot(param.t, 2*2*plot_omega(:,4,1),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('${\omega}^1(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('DS-weights','Interpreter','Latex','Fontsize',16);
legend([l31, l32, l33, l34], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(2,3,4)
l10 = plot(param.t, param.rho*exp(-param.rho*param.t),'k--','LineWidth',2); hold on;
l11 = plot(param.t, 2*plot_omega_dyn(:,1,2),'color',[000,076,153]./255,'LineWidth',2); hold on;
l12 = plot(param.t, 2*plot_omega_dyn(:,2,2),'color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}^2(t|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Dynamic Component','Interpreter','Latex','Fontsize',16);
legend([l10, l11, l12,], ...
    {'$\rho e^{-\rho t}$', '$z = L$', '$z=H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(2,3,5)
l21 = plot(param.t, 2*plot_omega_sto(:,1,2),'color',[000,076,153]./255,'LineWidth',2); hold on;
l22 = plot(param.t, 2*plot_omega_sto(:,2,2),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l23 = plot(param.t, 2*plot_omega_sto(:,3,2),'color',[064,173,090]./255,'LineWidth',2); hold on;
l24 = plot(param.t, 2*plot_omega_sto(:,4,2),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('$\tilde{\omega}^2(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('Stochastic Component','Interpreter','Latex','Fontsize',16);
legend([l21, l22, l23, l24], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

subplot(2,3,6)
l31 = plot(param.t, 2*2*plot_omega(:,1,2),'color',[000,076,153]./255,'LineWidth',2); hold on;
l32 = plot(param.t, 2*2*plot_omega(:,2,2),'--','color',[000,076,153]./255,'LineWidth',2); hold on;
l33 = plot(param.t, 2*2*plot_omega(:,3,2),'color',[064,173,090]./255,'LineWidth',2); hold on;
l34 = plot(param.t, 2*2*plot_omega(:,4,2),'--','color',[064,173,090]./255,'LineWidth',2); hold on;
xlim([0, param.T])
xlabel('$t$ (time)','Interpreter','Latex','Fontsize',13);
ylabel('${\omega}^2(t,x|0,z;\theta=0.25)$','Interpreter','Latex','Fontsize',13);
title('DS-weights','Interpreter','Latex','Fontsize',16);
legend([l31, l32, l33, l34], ...
    {'$z = L, x = L$', '$z = L, x = H$', '$z = H, x = L$', '$z = H, x = H$'}, ...
    'Interpreter', 'Latex', 'box', 'off', 'Location', 'NorthEast','Fontsize',10)

exportgraphics(gcf, ['./output/replicate_fig7-',num2str(round(param.la1,3)),'.eps']);
