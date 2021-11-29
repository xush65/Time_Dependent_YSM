%Load qlist before evrything here.
c=1/2;
Mat1 = Matrix1(qList1,c);
Mat2 = Matrix2(qList1,chi1,xi1,c);
Mat3 = Matrix3(qList1,c);

M=inv(Mat1)*(Mat2-Mat3);

M2=inv(Mat1)*Mat2;
M3=inv(Mat1)*Mat3;
% max(max(M2))
% max(max(M3))
% max(max(M))
% min(min(M2))
% min(min(M3))
% min(min(M))
% z=eig(M);
% plot(z,'.')
I=eye(length(qList1));
q=zeros(length(qList1),1);
testK=qList1;
interval=1/100000;
for t = 0:interval:0.01
    q=inv(I+interval/2*M)*(I-interval/2*M)*q+inv(I+interval/2*M)*(0.01*(testK+testK*t))*interval;
    max(q)
    min(q)
    t
    %pause
end

% fun=@(eps)((qList2-qList1-eps*q)'*(qList2-qList1-eps*q));
% eps0 = fminbnd(fun,-1,1);