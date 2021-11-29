function [sparseM] = computeSparseM(n, c)

h = 1.0/(n+1);
numNonzeros = 0;

for i = 1:n
    for j = 1:n
        if (i == (n-1))
            numNonzeros = numNonzeros + 1;
        elseif ((i == n) && (j < n))
            numNonzeros = numNonzeros + 1;
        elseif ((i == n) && (j == n))
            numNonzeros = numNonzeros + 1;
        elseif (j == (i-1))
            numNonzeros = numNonzeros + 1;
        elseif (j == i)
            numNonzeros = numNonzeros + 1;
        elseif (j == (i+1))
            numNonzeros = numNonzeros + 1;
        elseif (j == (i+2))
            numNonzeros = numNonzeros + 1;
        elseif (j == (i+3))
            numNonzeros = numNonzeros + 1;
        end
    end
end

rows = zeros(numNonzeros, 1);
cols = zeros(numNonzeros, 1);
values = zeros(numNonzeros, 1);
index = 0;

for i = 1:n
    for j = 1:n
        if (i == (n-1)) % test function is 1
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = h;
        elseif ((i == n) && (j < n)) % test function is w
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/4).*h.^(-1).*c.*(h.*(2+h.*(3+(-2).*j))+h.*((-2)+h.*(3+2.*j) ...
  )+2.*((-1)+h.*((-2)+j)).*((-1)+h.*j).*log(1+(-1).*h.*j)+2.*((-1)+ ...
  h.*j).*((-1)+h.*(2+j)).*log(1+(-1).*h.*j)+(-2).*(1+h+(-1).*h.*j) ...
  .^2.*log(1+h+(-1).*h.*j)+(-2).*((-1)+h+h.*j).^2.*log(1+(-1).*h.*( ...
  1+j)));
        elseif ((i == n) && (j == n))
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/4).*h.^(-1).*c.*(h.*(2+h.*(3+(-2).*j))+h.^2.*(1+(-2).*log( ...
  h))+2.*((-1)+h.*((-2)+j)).*((-1)+h.*j).*log(1+(-1).*h.*j)+(-2).*( ...
  1+h+(-1).*h.*j).^2.*log(1+h+(-1).*h.*j));
        elseif (j == (i-1))
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/12).*h;
        elseif (j == i)
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/2).*h;
        elseif (j == (i+1))
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (5/6).*h;
        elseif (j == (i+2))
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/2).*h;
        elseif (j == (i+3))
            index = index + 1;
            rows(index) = i;
            cols(index) = j;
            values(index) = (1/12).*h;
        end
    end
end

sparseM = sparse(rows, cols, values, n, n);
end