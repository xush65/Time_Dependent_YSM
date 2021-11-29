function val = ComputeNorm(diff, numElements, N, W, chi, zeta, wZero, q)
%COMPUTENORM �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
sparseR = computeSparseR(numElements, N, W, chi, zeta, wZero);
%calculate S
sparseS = computeSparseS(numElements, N, W, chi, zeta, wZero);
sparseM = computeSparseM(numElements, wZero);

sparseTmp = (sparseR + reshape(q' * sparseS, numElements, numElements));

rhs = (sparseTmp) * q;

val=norm(rhs-sparseM*diff);
end

