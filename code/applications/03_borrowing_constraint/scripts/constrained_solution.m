
%% Borrowing Constraint Grid
[b_bar_min,b_bar_max,b_bar_spc] = deal(0,1.2*b0_unconstrained(1),0.02);
b_bar_grid                      = (b_bar_min:b_bar_spc:b_bar_max)';

%% Initializing variables
[b0_opt, c1_opt_1, c1_opt_2, V_opt]  = deal(zeros(length(b_bar_grid),2));
[q0_opt, k0_opt, c0_opt_1, c0_opt_2] = deal(zeros(length(b_bar_grid),1));


%% Constrained Solution
for i = 1:length(b_bar_grid)

    % Price
    fun_q     = @(x) fn_resid_q(x,beta,n0,n1,z,pi,gamma,phi,b_bar_grid(i));
    x0        = 0.9;
    q0_opt(i) = broyden(fun_q,0.9).*(b_bar_grid(i)<b0_unconstrained(1))...
              + q0_unconstrained.*(b_bar_grid(i)>=b0_unconstrained(1));
    
    % Optimal borrowing
    b0_opt(i,:) = [min(b_bar_grid(i),b0_unconstrained(1)),...
                  (-1)*min(b_bar_grid(i),b0_unconstrained(1))];

    % Optimal Investment
    fun_k     = @(x) fn_k_resid(x,min(b_bar_grid(i),b0_unconstrained(1)),q0_opt(i),n0(1),n1(1,:),z,pi,gamma(1),phi,beta(1));
    k0_opt(i) = broyden(fun_k,1);

    % Optimal Consumption
    c0_opt_1(i)   = fn_c0(min(b_bar_grid(i),b0_unconstrained(1)),k0_opt(i),q0_opt(i),n0(1),phi);
    c0_opt_2(i)   = fn_c0((-1)*min(b_bar_grid(i),b0_unconstrained(1)),0,q0_opt(i),n0(2),phi);
    c1_opt_1(i,:) = fn_c1(min(b_bar_grid(i),b0_unconstrained(1)),k0_opt(i),n1(1,:),z);
    c1_opt_2(i,:) = fn_c1((-1)*min(b_bar_grid(i),b0_unconstrained(1)),0,n1(2,:),z);

    % Indirect Utility Functions
    V_opt(i,:)  = [fn_u(c0_opt_1(i),c1_opt_1(i,:),beta(1),pi,gamma(1));
                   fn_u(c0_opt_2(i),c1_opt_2(i,:),beta(2),pi,gamma(2))];
end

fprintf('Constrained Solution DONE\n')

fig_eq(b_bar_grid,b0_opt,k0_opt,c0_opt_1,c0_opt_2,c1_opt_1,c1_opt_2,q0_opt,b0_unconstrained,optfig)

%% Check (Investor's Borrowing FOC > 0)

idx = find(b0_opt == b0_unconstrained(1)) - 1; % Test only the F.O.Cs where \bar{b} < b^u

parfor i = 1:length(b_bar_grid(1:idx))
    u_prime_1    = fn_u_prime(b0_opt(i,1),k0_opt(i),q0_opt(i),n0(1),n1(1,:),z,gamma(1),phi);
    b_1_check(i) = q0_opt(i)*u_prime_1(1) - beta(1)*(pi(1)*u_prime_1(2)+pi(2)*u_prime_1(3));
end

if min(b_1_check) < 0
    fprintf('CHECK CONSTRAINED SOLUTION\n')
end


