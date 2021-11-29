function  sol= fw(w,C0)
%transform data of w into compact domain [0,1]
if (nargin<2)
    C0=2.0;
end
sol=1-exp(-w/C0);
end

