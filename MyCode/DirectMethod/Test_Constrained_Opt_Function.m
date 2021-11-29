MT = -rand(16,3);
rhs= rand(16,1);

a=MT\rhs
a(1)=0;
a2=Constrained_Opt(MT, rhs)