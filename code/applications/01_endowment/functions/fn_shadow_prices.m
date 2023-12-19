function [q_state_price, q_zero_coupon, q_consol_bond] = fn_shadow_prices(u_prime,lambda,Pi,beta,I,S,T)

% Initializing Variables
[q_state_price]     = deal(zeros(S,S,I));
[q_zero_coupon]     = deal(zeros(S,T,I));
[q_consol_bond]     = deal(zeros(S,I));

% State-price
for s0 = 1:S
    for s1 = 1:S
        parfor i = 1:I
            q_state_price(s0,s1,i) = (beta(i)) *Pi(s0,s1)* (u_prime(s1,i)/u_prime(s0,i));
        end
    end
end

% Zero-Coupon Bond
for i = 1:I
    parfor t = 1:T
        q_zero_coupon(:,t,i) = q_state_price(:,:,i)^(t-1)*ones(S,1);
    end
end

% Consol Bond
q_consol_bond = lambda./u_prime;
%q_consol_bond = [(eye(S) - q_state_price(:,:,1))\ones(S,1), (eye(S) - q_state_price(:,:,2))\ones(S,1)];
%q_consol_bond = squeeze(sum(q_zero_coupon),2);

end

