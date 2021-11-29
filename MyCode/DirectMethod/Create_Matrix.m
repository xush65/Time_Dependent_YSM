n=799; V=1; W=1; c=2.0;
while 1
    chi=3*rand();
    zet=3*rand();
    if (chi>=zet)
        break;
    end
end
chi 
zet
% M0=computeSparseM(n, c);
% save('Matrix_M.mat','n', 'V', 'W', 'c', 'M0');
% M=load('Matrix_M.mat').M0;
% 
% R00=computeSparseR(n, V, W, 0, 0, c);
% R01=computeSparseR(n, V, W, 0, 1, c)-R00;
% R10=computeSparseR(n, V, W, 1, 0, c)-R00;
% save('Matrix_R.mat','n', 'V', 'W', 'c', 'R00','R01','R10');
% r=load('Matrix_R.mat');
% 
%S0=computeSparseS(n, V, W, 0, 0, c);
%S1=computeSparseS(n, V, W, 1, 1, c)-S0;
%save('Matrix_S.mat','n', 'V', 'W', 'c', 'S0','S1');
%s=load('Matrix_S.mat');

R=chi*r.R10+zet*r.R01+r.R00;
S=zet*s.S1+s.S0;

eR=computeSparseR(n, V, W, chi, zet, c)-R;
eS=computeSparseS(n, V, W, chi, zet, c)-S;