function [networth] = ReadDataUS(year, dict)
%Read Data from xlsx file from SCF data 
%The current data available is 2016 on 
%https://www.federalreserve.gov/econres/scfindex.htm
%Takes around a few minutes to read a data
if nargin==1
    dict="F:\CountryData";
end
path=dict+"\US"+string(year)+".xlsx";
[num,txt]=xlsread(path);
s=size(txt);
for i = 1:s(2)
    if txt(i)=="NETWORTH"
        break;
    end
end
networth=num(:, i);
end
