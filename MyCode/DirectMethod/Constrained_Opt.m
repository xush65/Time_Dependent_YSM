function a = Constrained_Opt(MT, rhs)
%CONSTRAINED_OPT 
%  a is the result: a0 is 1/t; a1 is x; a2 is z
%  We solve a least square problem for Mt*a=rhs with the constraint: a0>=0;

a_init=MT\rhs;
a(1)=0;
opt_func=@(q) (MT*q-rhs)'*(MT*q-rhs);

[a, ~]=fmincon(opt_func, a_init, [-1 0 0], [0]);
end

