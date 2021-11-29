function Mat1 = Matrix1(qList,c)
if (nargin==1)
    c=1;
end
n=length(qList);
h=1/(n+1);

Mat1=zeros(n,n);
for i = 1:n
    for j = 1:n
        if (i == (n-1)) % test function is 1
            Mat1(i,j) = h;
        elseif ((i == n) && (j < n)) % test function is w
            Mat1(i,j) = (1/4).*c.^(-1).*h.^(-1).*((-1).*h.*((-2)+h.*((-3)+2.*j))+h.*((-2)+ ...
  h.*(3+2.*j))+2.*((-1)+h.*((-2)+j)).*((-1)+h.*j).*log(1+(-1).*h.*j) ...
  +2.*((-1)+h.*j).*((-1)+h.*(2+j)).*log(1+(-1).*h.*j)+(-2).*(1+h+( ...
  -1).*h.*j).^2.*log(1+h+(-1).*h.*j)+(-2).*((-1)+h+h.*j).^2.*log(1+( ...
  -1).*h.*(1+j)));
        elseif ((i == n) && (j == n))
            Mat1(i,j) = 1/2.*c.^(-1).*((-2).*log(4)+h.*(3+j.*log(16))+(-2).*h.*log(h)); 
        elseif (j == (i-1))
            Mat1(i,j) = (1/12).*h;
        elseif (j == i)
            Mat1(i,j) = (1/2).*h;
        elseif (j == (i+1))
            Mat1(i,j) = (5/6).*h;
        elseif (j == (i+2))
            Mat1(i,j) = (1/2).*h;
        elseif (j == (i+3))
            Mat1(i,j) = (1/12).*h;
        end
    end
end
end

