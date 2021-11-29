function Mat2 = Matrix2(qList,chi,zeta,c)
%MATRIX2 

if (nargin==3)
    c=1;
end
n=length(qList);
h=1/(n+1);

Mat2=zeros(n,n);
for i = 1:(n-2)
    for j = max(i-1,1):min(i+3,n)
        a= M2(j,h, chi, zeta,c); %%[m2L1, m2L2,m2R1, m2R2, F1,F2];
        if (j==i-1)
            Mat2(i,j)=1/21600/(2*h^3)*(a(3)*qList(j) + a(4)*qList(j+1))...
                 +a(6)/2/h;
        elseif (j==i)
            t=a(2)*qList(j)+a(3)*qList(j)+ a(4)*qList(j+1);
            if (j>1)
                t=t+a(1)*qList(j-1);
            end
            Mat2(i,j)=t/21600/(2*h^3)...
                 +(a(5)+a(6))/2/h;
        elseif (j==i+1)
            t=a(1)*qList(j-1)+a(2)*qList(j)-a(3)*qList(j) - a(4)*qList(j+1);
            Mat2(i,j)=t/21600/(2*h^3)...
                 +(a(5)-a(6))/2/h;
        elseif (j==i+2)
            t=a(1)*qList(j-1)+a(2)*qList(j)+a(3)*qList(j);
            if (j<=n-1)
                t=t+a(4)*qList(j+1);
            end
            Mat2(i,j)=-t/21600/(2*h^3)...
                 -(a(5)+a(6))/2/h;
        elseif (j==i+3)
            Mat2(i,j)=-1/21600/(2*h^3)*(a(1)*qList(j-1)+a(2)*qList(j))...
                 -a(5)/2/h;
        end
    end
end
%i=n
for j =1:n
    a=M2n(j,h, chi, zeta,c);
    Mat2(n,j)=1/21600/(h^2)*(a(1)+a(2)+a(3)+a(4))...
         +a(5)+a(6);
end

Mat2(n-2,n)=M2F(h,chi,zeta,c);
Mat2(n,n)=M2nn(h,chi,zeta,c);
end

