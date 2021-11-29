function coef0 = FEMCoef(fun, numElements)
%FEMCOEF 
%Transfer function into coef of FEM
%The domain is [0,1]. h=1/(1+numElements)
%fun is the function on [0,1] to be transfered. 
%fun need to be able to use to integral funciton.

h=1/(1+numElements);
n=numElements;

%% Construct Matrix
D=sparse(1:n, 1:n, 2/3*h*ones(1,n),n,n);
E=sparse(2:n, 1:(n-1), 1/6*h*ones(1,n-1),n,n);
M=E+D+E';

%% Constuct <f, test_functin>
coef=zeros(n,1);
for i=1:n
    l=@(x) fun(x).*(x/h-(i-1));
    r=@(x) fun(x).*(-x/h+(i+1));
    coef(i)=integral(l,(i-1)*h, i*h) + integral(r,i*h, (i+1)*h);
end

coef0=M\coef;
end

