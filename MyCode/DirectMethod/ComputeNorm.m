function val = ComputeNorm(diff, numElements, N, W, chi, zeta, wZero, q)
%COMPUTENORM 此处显示有关此函数的摘要
%   此处显示详细说明
sparseR = computeSparseR(numElements, N, W, chi, zeta, wZero);
%calculate S
sparseS = computeSparseS(numElements, N, W, chi, zeta, wZero);
sparseM = computeSparseM(numElements, wZero);

sparseTmp = (sparseR + reshape(q' * sparseS, numElements, numElements));

rhs = (sparseTmp) * q;

val=norm(rhs-sparseM*diff);
end

