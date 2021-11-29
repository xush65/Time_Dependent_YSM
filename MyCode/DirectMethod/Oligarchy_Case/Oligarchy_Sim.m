%% Paper ADRIAN2017
chi0=0.048; zeta0=0.066;
chi1=0.036; zeta1=0.05;

%% Equation 14 in the paper
n=1000; % Time step=1/n
t_step=1/n;
chi=chi0:(chi1-chi0)/n:chi1;
zeta=zeta0:(zeta1-zeta0)/n:zeta1;
% dc/dt=zeta(1-chi/zeta-c);
c=1-chi0/zeta0;
for i=1:n
   c=c+t_step*zeta(i+1)*(1-chi(i+1)/zeta(i+1)-c)
end
