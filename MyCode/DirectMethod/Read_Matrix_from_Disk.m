function [M,R,S]=Read_Matrix_from_Disk(chi, z, M0, R10, R01, R00, S1, S0)
if (nargin==2)
load('Matrix_M.mat')
load('Matrix_R.mat');
load('Matrix_S.mat');
else
M=M0;
R=chi*R10+z*R01+R00;
S=z*S1+S0;
end

% M = computeSparseM(numElements, wZero);
% R = computeSparseR(numElements, N, W, chi, z, wZero);
%     %calculate S
% S = computeSparseS(numElements, N, W, chi, z, wZero);
end
