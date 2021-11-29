function [chi, zeta] = OptimizationMain(chi0, zeta0, chi1, zeta1)

numElements=799;
[q1,~]=Read_Coef(chi0, zeta0);
[q2,~]=Read_Coef(chi1, zeta1);
N=1; W=1; wZero=2;
diff=q2-q1
%calculate R
chi=chi0;
zeta=zeta0;

err=ComputeNorm(diff, numElements, N, W, chi0, zeta0, wZero, q1)

%stepsize;
s1=0.05*chi;
s2=0.05*zeta;

%Min step size
smin=0.001;

while (s1>smin || s2>smin)
    if (s1>smin)
        err1=ComputeNorm(diff, numElements, N, W, chi+s1, zeta0, wZero,q1);
        if (err1<err)
            err=err1
            chi=chi+s1;
        else 
            err2= ComputeNorm(diff, numElements, N, W, chi-s1, zeta0, wZero, q1);
            if (err2<err)
                err=err2
                chi=chi-s1;
            else
                s1=s1/2
            end
        end
    end
    
    if (s2>smin)
        err1=ComputeNorm(diff, numElements, N, W, chi, zeta0+s2, wZero,q1);
        if (err1<err)
            err=err1
            zeta=zeta+s2;
    
        else 
            err2= ComputeNorm(diff, numElements, N, W, chi, zeta0-s2, wZero, q1);
            if (err2<err)
                err=err2
                zeta=zeta-s2;
            else
                s2=s2/2
            end
        end
    end
    chi
    zeta
end

end

