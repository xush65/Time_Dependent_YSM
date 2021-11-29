load('Result.mat')
load('Matrix_S.mat')
load('Matrix_R.mat')
load('Matrix_M.mat')
load ('Result.mat')
m=size(res, 2);
% 
rd=randi([0.4*m,0.6*m]);
% % 
%l=rd-fix(0.3*m);
%r=rd+fix(0.3*m);
% % %res(:,l)
% % 
%chi_init=chi0+(chi1-chi0)*rd/size(res, 2)
%zeta_init=zeta0+(zeta1-zeta0)*rd/size(res, 2)
% % 
%[q_init,~] = FEM_Data_initial_q_perturbation(chi_init, zeta_init, N, W, wZero, ...
%                  numElements, timeStep, timeIters, 1);

delta_q=(res(:,l)-res(:,r))/((l-r)/m);
MT=[M0*delta_q, -R01*q_init, -R10*q_init-reshape(q_init' * S1, numElements, numElements)*q_init];
rhs=(R00+chi_init*R01+zeta_init*R10)*delta_q...
    +reshape(q_init' * S0, numElements, numElements)*delta_q...
    +reshape(delta_q' * S0, numElements, numElements)*q_init...
    +zeta_init*reshape(q_init' * S1, numElements, numElements)*delta_q...
    +zeta_init*reshape(delta_q' * S1, numElements, numElements)*q_init;
% MT'*MT
% MT'*rhs
a=MT\rhs;
a(4:11)=[chi0,zeta0, chi1, zeta1, timeIters, timeStep, l, r];
try
  load('Recovering.mat')   %I can't load this file
catch
  pre_res=zeros(11,1)';
  disp('Did not load that last file, but it''s ok.'); 
end
pre_res = vertcat(pre_res,a')
save('Recovering.mat','pre_res');