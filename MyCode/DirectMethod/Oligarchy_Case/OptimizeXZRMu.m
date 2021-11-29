function [DeltaChi, DeltaZeta, gamma, DeltaMu, P0,...
          DeltaP, Qflow, MT, rhs, rhs2] = OptimizeXZRMu(chi0, zeta0,...
          chi1, zeta1, n, dictionary)
%OPTIMIZEXZRMU 
% Solve for the perturbated parameters
% chi0, zeta0, chi1, zeta1 are the parameters of t=0 and t=1;
% dictionary is the folder to read fitting data from
% n is the basis to be trasfered into, i.e. if the basis is 9999 from
% database, but you want 4999 basis function. You can set n=4999 to get new
% basis

% Set n=2499 For United State

%Return
% DeltaChi, DeltaZeta, DeltaMu: change of Chi, Zeta, Mu
% gamma: the prediction of frequecy

if (nargin<6)
    dictionary='F:\WealthDistributionData\WealthDistributionDatabase\';
end

P0=Read_Coef_Oligarchy(chi0, zeta0, dictionary);
P1=Read_Coef_Oligarchy(chi1, zeta1, dictionary);
if (nargin==5)
    [P0,~]=FEMBasisTrans(P0, n);
    [P1,~]=FEMBasisTrans(P1, n);
    numElements=n;
    P0=P0(:);
    P1=P1(:);
else
    P0=P0(:);
    P1=P1(:);
    numElements=size(P0);
    numElements=numElements(1);
end
DeltaP=P1-P0;
Mu0=min(1,chi0/zeta0);
%%Load the matrix First; optimize Mx=b
%%x consist [1/gamma, DeltaChi, DeltaZeta, DeltaMu]
exchange=false;
mu0=1;
if (chi0<zeta0)
    mu0=chi0/zeta0;
    t=chi0;
    chi0=zeta0;
    zeta0=t;
    exchange=true;
end

folder_name=char(strcat('MatV2_',string(numElements)));
if (exist(folder_name,'dir')==0)
    Create_Matrix_to_Disk_Oligarchy(1, 1, chi0, zeta0, 0, numElements, 2);
end
addpath(folder_name);
MatrixM=char(strcat('MatrixM',string(n),'V2.mat'));
MatrixR=char(strcat('MatrixR',string(n),'V2.mat'));
MatrixS=char(strcat('MatrixS',string(n),'V2.mat'));
load(MatrixM);
load(MatrixR);
load(MatrixS);

rmpath(folder_name);
% Construct M of Mx on the left hand side:
MT=[M0*DeltaP, ...
    -Mu0*R101*P0-R100*P0, ...
    -(1/Mu0*R011*P0+R100*P0)-(1/Mu0*reshape(P0'*S011, numElements, numElements)*P0)-(reshape(P0'*S010, numElements, numElements)*P0),...
    -chi0*R101*P0+zeta0/(Mu0^2)*(R011*P0+reshape(P0'*S011, numElements, numElements)*P0)
    ];
rhs= chi0*(Mu0*R101+R100)*DeltaP+zeta0*(1/Mu0*R011+R010)*DeltaP...
    +zeta0*(1/Mu0*reshape(P0'*S011, numElements, numElements)*DeltaP)...
    +zeta0*(reshape(P0'*S010, numElements, numElements)*DeltaP)...
    +zeta0*(1/Mu0*reshape(DeltaP'*S011, numElements, numElements)*P0)...
    +zeta0*(reshape(DeltaP'*S010, numElements, numElements)*P0)...
    +reshape(DeltaP'*S000, numElements, numElements)*P0...
    +reshape(P0'*S000, numElements, numElements)*DeltaP;

rhs2=[chi0*(Mu0*R101+R100)*DeltaP, zeta0*(1/Mu0*R011+R010)*DeltaP,...
    +zeta0*(1/Mu0*reshape(P0'*S011, numElements, numElements)*DeltaP),...
    +zeta0*(reshape(P0'*S010, numElements, numElements)*DeltaP),...
    +zeta0*(1/Mu0*reshape(DeltaP'*S011, numElements, numElements)*P0),...
    +zeta0*(reshape(DeltaP'*S010, numElements, numElements)*P0),...
    +reshape(DeltaP'*S000, numElements, numElements)*P0,...
    +reshape(P0'*S000, numElements, numElements)*DeltaP];

res=Constrained_OptXZRMU(MT, rhs, mu0, chi0, zeta0);
gamma=1/res(1); DeltaChi=res(2); DeltaZeta=res(3); DeltaMu=-res(4);
if (exchange)
    t=DeltaChi;
    DeltaChi=DeltaZeta;
    DeltaZeta=t;
end

%% Please Note this is the negative agent flow caused by Parameter change,
%  
Qflow=-MT(:, 2)*DeltaChi-MT(:,3)*DeltaZeta-MT(:,4)*res(4);
end

