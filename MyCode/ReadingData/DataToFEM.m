function [res, qr]= DataToFEM(data, numElements)
%DATATOFEM 
% Transform Data to PDF and then to FEM vectors.
% Data is the coefficient from the fitting database. 
% The size of data should be either 799 or 9999
%

% numElements: number of elements we want to out put according to the
%          number of elements for FEM Method.Recommending 799, 1599 or 4999.

if (nargin<2)
    numElements=4999;
end

S=size(data);
h= 1/(1+S(1));
interval= 0:h:1;

% Interpolate: Spline
MA = makima(interval,[0 data' 0]);
pdf2=@(x) ppval(MA, x);
q2=integral(pdf2, 0,1) % Check q2=1 for integration
figure;
plot(interval,ppval(MA, interval))
res=FEMCoef(pdf2, numElements);
qr=sum(res)/(1+numElements)
end

