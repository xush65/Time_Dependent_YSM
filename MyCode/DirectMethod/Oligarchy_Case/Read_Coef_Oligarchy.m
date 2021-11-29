function [qList, ind]= Read_Coef_Oligarchy(chi, zeta,dictionary)
%READ_COEF_Oligarchy
%use Read_coef and duality to import distribution

if (nargin==2)
    dictionary='F:\WealthDistributionData\WealthDistributionDatabase\';
end
if chi>=zeta
    [qList, ind]=Read_Coef(chi, zeta,dictionary);
else
    [qList, ind]=Read_Coef(zeta, chi,dictionary);
    qList=chi/zeta*qList;
end
end

