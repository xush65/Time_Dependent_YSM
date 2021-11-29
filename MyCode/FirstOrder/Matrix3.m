function Mat3 = Matrix3(qList,c)
%MATRIX3
if (nargin==1)
    c=1;
end

n=length(qList);
h=1/(n+1);

Mat3=zeros(n,n);
for i = 1:(n-2)
    for j = max(i-1,1):min(i+3,n)
        a= M3(j,h,c); %%[m2L1, m2L2,m2R1, m2R2];
        if (j==i-1)
            Mat3(i,j)=1/21600/(2*h^3)*(a(3)*qList(j) + a(4)*qList(j+1));
        elseif (j==i)
            t=a(2)*qList(j)+a(3)*qList(j)+ a(4)*qList(j+1);
            if (j>1)
                t=t+a(1)*qList(j-1);
            end
            Mat3(i,j)=t/21600/(2*h^3);
        elseif (j==i+1)
            t=a(1)*qList(j-1)+a(2)*qList(j)-a(3)*qList(j) - a(4)*qList(j+1);
            Mat3(i,j)=t/21600/(2*h^3);
        elseif (j==i+2)
            t=a(1)*qList(j-1)+a(2)*qList(j)+a(3)*qList(j);
            if (j<=n-1)
                t=t+a(4)*qList(j+1);
            end
            Mat3(i,j)=-t/21600/(2*h^3);
        elseif (j==i+3)
            Mat3(i,j)=-1/21600/(2*h^3)*(a(1)*qList(j-1)+a(2)*qList(j));
        end
    end
end
%i=n
for j =1:n
    a=M3n(j,h,c);
    Mat3(n,j)=1/21600/(h^2)*(a(1)+a(2)+a(3)+a(4));
end
Mat3(n-2,n)=M3F(h,c);
%Mat3(n,n)=M3nn(h, chi, zeta,c);
end

