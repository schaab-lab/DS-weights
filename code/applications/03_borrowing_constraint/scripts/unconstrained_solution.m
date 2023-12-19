
fun_u            = @(x) fn_resid_bkq(x,beta,n0,n1,z,pi,gamma,phi);
x0               = [0.01,0.01,1,0.9];
options          = optimoptions('fsolve','Display','off','FunctionTolerance',10e-15);
sol_u            = fsolve(fun_u,x0,options);

% Unconstrained Optimal Investment/Borrowing
b0_unconstrained = [sol_u(1), sol_u(2)];
k0_unconstrained = [sol_u(3)];

% Unconstrained Price
q0_unconstrained = sol_u(4);

% Unconstrained consumption
c0_unconstrained = [fn_c0(b0_unconstrained(1),k0_unconstrained,q0_unconstrained,n0(1),phi);
                    fn_c0(b0_unconstrained(2),0,q0_unconstrained,n0(2),phi)];
c1_unconstrained = [fn_c1(b0_unconstrained(1),k0_unconstrained,n1(1,:),z);
                    fn_c1(b0_unconstrained(2),0,n1(2,:),z)];

% Unconstrained Indirect Utility Function
V_unconstrained  = [fn_u(c0_unconstrained(1),c1_unconstrained(1,:),beta(1),pi,gamma(1));
                    fn_u(c0_unconstrained(2),c1_unconstrained(2,:),beta(2),pi,gamma(2))];

fprintf('Unconstrained Solution DONE\n')

% Checks
resid_check_u         = fn_resid_bkq(sol_u,beta,n0,n1,z,pi,gamma,phi);
u_prime_1_u           = fn_u_prime(b0_unconstrained(1),k0_unconstrained(1),q0_unconstrained,n0(1),n1(1,:),z,gamma(1),phi);
u_prime_2_u           = fn_u_prime(b0_unconstrained(2),0,q0_unconstrained,n0(2),n1(2,:),z,gamma(2),phi);
Unconstrained_check_1 = beta(1)*((pi(1)*u_prime_1_u(2)+pi(2)*u_prime_1_u(3))/u_prime_1_u(1));
Unconstrained_check_2 = beta(2)*((pi(1)*u_prime_2_u(2)+pi(2)*u_prime_2_u(3))/u_prime_2_u(1));

if max(abs(resid_check_u))>10^(-3) || abs(Unconstrained_check_1-Unconstrained_check_2)>10^(-3) || abs(Unconstrained_check_1-q0_unconstrained)>10^(-3) || abs(Unconstrained_check_2-q0_unconstrained)>10^(-3)
    fprintf('CHECK UNCONSTRAINED PROBLEM\n')
end
