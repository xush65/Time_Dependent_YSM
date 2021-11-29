function [M0, tempR, tempS] = Create_Matrix_from_Compute(N, W, chi, zeta, n, c)
% Create Matrix and save to the disk
% n is the number of basis functions
% N is number of people
% W is total wealth of the system
% chi is chi 
% z is zeta
% c is the wZero parameter in f(theta)
% Update is the flag to update pre-computed matrix, default 0. Use 1 when
% you want to update all matrix.

% Use this to verify you result from create_matrix to disk
if (nargin<6)
    c=2.0;
end

if (nargin<5)
    n=799;
end

tempR=computeSparseR(n, N, W, chi, zeta, c);
tempS=computeSparseS(n, N, W, chi, zeta, c);
M0=computeSparseM(n, c);
end

