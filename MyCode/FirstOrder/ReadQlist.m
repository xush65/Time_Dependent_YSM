chi1=0.3; xi1=0.2; chi2=0.5;xi2=0.2;
qList1=Read_Coef(chi1, xi1);
qList2=Read_Coef(chi2, xi2);

DqDchi=(Read_Coef(chi1+0.002, xi1)-Read_Coef(chi1-0.002, xi1))/0.004;
DqDxi=(Read_Coef(chi1, xi1+0.002)-Read_Coef(chi1, xi1-0.002))/0.004;
Dq0=DqDchi*(chi2-chi1)+DqDxi*(xi2-xi1);

DqDchi=(Read_Coef(chi2+0.002, xi1)-Read_Coef(chi2-0.002, xi2))/0.004;
DqDxi=(Read_Coef(chi2, xi2+0.002)-Read_Coef(chi2, xi2-0.002))/0.004;
Dq1=DqDchi*(chi2-chi1)+DqDxi*(xi2-xi1);

% for t = 0:interval:1
%     q=q+(Dq+M*q)*interval;
%     
% end
% 
% fun=@(eps)((qList2-qList1-eps*q)'*(qList2-qList1-eps*q));
% eps0 = fminbnd(fun,-1,1);
