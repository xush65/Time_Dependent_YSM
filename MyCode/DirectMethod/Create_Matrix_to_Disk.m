function [M, R, S] = Create_Matrix_to_Disk(n, V, W, chi, z, c)
% Create Matrix and save to the disk
% n is the number of basis functions
% V is N
% W is total wealth of the system
% chi is chi 
% z is zeta
% c is the wZero parameter in f(theta)

% By linearity,R = chi*r.R10+z*r.R01+r.R00;
% i.e. R10 means R(chi=1, zeta=1)

% By linearity,S=z*s.S1+s.S0;
% i.e. S1 means S(zeta=1) (S is not related to chi)

% Save Matrix for future convinience;

h = 1.0/(n+1);

M0=computeSparseM(n, c);
save('Matrix_M.mat','n', 'V', 'W', 'c', 'M0');
M=load('Matrix_M.mat').M0;

R00=computeSparseR(n, V, W, 0, 0, c);
R01=computeSparseR(n, V, W, 0, 1, c)-R00;
R10=computeSparseR(n, V, W, 1, 0, c)-R00;
save('Matrix_R.mat','n', 'V', 'W', 'c', 'R00','R01','R10');
r=load('Matrix_R.mat');
R=chi*r.R10+z*r.R01+r.R00;

S0=computeSparseS(n, V, W, 0, 0, c);
S1=computeSparseS(n, V, W, 1, 1, c)-S0;
save('Matrix_S.mat','n', 'V', 'W', 'c', 'S0','S1');
s=load('Matrix_S.mat');
S=z*s.S1+s.S0;
end

