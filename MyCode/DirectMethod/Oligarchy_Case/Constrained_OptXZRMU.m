function a = Constrained_OptXZRMU(MT, rhs, mu0, chi, zeta)
%CONSTRAINED_OPT 
%  a is the result: a0 is 1/t; a1 is x; a2 is z
%  We solve a least square problem for Mt*a=rhs with the constraint: a0>=0;
mu0, chi, zeta,
a_init=zeros(4,1);
a(1)=0;
a(4)=0;
opt_func=@(q) (MT*q-rhs)'*(MT*q-rhs);
con_func=@(q) confun(q, mu0, chi, zeta);
[a, ~]=fmincon(opt_func, a_init, [-1 0 0 0; 0 1 0 0; 0 -1 0 0; 0 0 1 0; ...
    0 0 -1 0; 0 0 0 1; 0 0 0 -1], ...
    [0, 0.3*chi, 0.3*chi, 0.3*zeta, 0.3*zeta, max(0.3*mu0, 1-mu0), 0.3*mu0],...
    [],[],[],[]...
    ,con_func);
end

function [c, ceq]=confun(q,mu0, chi, zeta)
    c=abs((zeta+q(3))/(chi+q(2))/(mu0-q(4))-1)-0.025;
    ceq=[];
end