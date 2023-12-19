function fig_app1_fixed(omega,omega_i,omega_t,omega_s,omega_t_ref,T_fig,rho,optfig)

rho = strrep(num2str(rho),'.',''); % For saving persistence

fig_weights_dynamic(omega_t(:,:,1),omega_t_ref(:,:,1),T_fig,'_01',rho,optfig)
fig_weights_dynamic(omega_t(:,:,2),omega_t_ref(:,:,2),T_fig,'_02',rho,optfig)

fig_weights_stochastic(omega_s(:,:,:,1),T_fig,'_01',rho,optfig)
fig_weights_stochastic(omega_s(:,:,:,2),T_fig,'_02',rho,optfig)

fig_weights_DS(omega(:,:,:,1),omega_i,T_fig,'_01',rho,optfig)
fig_weights_DS(omega(:,:,:,2),omega_i,T_fig,'_02',rho,optfig)

end