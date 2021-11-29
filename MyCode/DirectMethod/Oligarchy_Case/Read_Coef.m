function [qList, ind] = Read_Coef(chi, zeta,dictionary)

if (nargin==2)
    dictionary='F:\WealthDistributionData\WealthDistributionDatabase\';
end

ind=getIndex(chi,zeta, dictionary);
ncol=-1; fileNo=-1;
if (chi<0.1)
    ncol=1274; fileNo=0;
else
    ncol=281494; fileNo=floor(ind/ncol)+1;
end
dat=getQDat(fileNo);
entryNo=mod(ind,ncol);
qList=dat(:,entryNo);
end

function ind=getIndex(chi,zeta, dict)

if (nargin==2)
    dict='F:\WealthDistributionData\WealthDistributionDatabase\';
end

deltaChi=0.002; deltaZ=0.002;
x=round(chi/deltaChi+1); y=round(zeta/deltaZ+1);
if (chi<0.1)
    load(strcat(dict,'indexMapA.mat'));
    ind=indexMap0(x,y);
else
    load(strcat(dict,'indexMapB.mat'));
    ind=indexMap(x,y);
end

end

function data=getQDat(filenum, dict)
if (nargin==1)
    dict='F:\WealthDistributionData\WealthDistributionDatabase\';
end
filename=strcat('QDatabase', int2str(filenum));
d=load(strcat(dict,filename,'.mat'));
data=eval(['d.', filename]);
end