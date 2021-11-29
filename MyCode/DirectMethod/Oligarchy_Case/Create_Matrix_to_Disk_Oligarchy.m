function [M, R, S] = Create_Matrix_to_Disk_Oligarchy(N, W, chi, zeta, update, n, c)
% Create Matrix and save to the disk
% n is the number of basis functions
% N is number of people
% W is total wealth of the system
% chi is chi 
% z is zeta
% c is the wZero parameter in f(theta)

% Update is the flag to update pre-computed matrix, default 0. Use 1 when
% you want to update all matrix.

% Save Matrix for future convinience;

%Default Settings
if (nargin<5)
    update=0;
end

if (nargin<7)
    c=2.0;
end

if (nargin<6)
    n=799;
end

h = 1.0/(n+1);

%Check whether matrix elements have being computed
folder_name=char(strcat('MatV2_',string(n)));
if (exist(folder_name,'dir')==0)
    mkdir(folder_name);
    update=1;
end

addpath(folder_name);
if (update==1)
    Create_Matrix_Helper(n,c);
end

%Compse the name of Matrix M, R, S
MatrixM=char(strcat('MatrixM',string(n),'V2.mat'));
MatrixR=char(strcat('MatrixR',string(n),'V2.mat'));
MatrixS=char(strcat('MatrixS',string(n),'V2.mat'));

try
    m=load(MatrixM);
    r=load(MatrixR);
    s=load(MatrixS);
catch
    disp('Fail to load one or more matrix! Recomputing>>>')
    Create_Matrix_Helper(n, c);
    m=load(MatrixM);
    r=load(MatrixR);
    s=load(MatrixS);
end

mu=W/N;
M=m.M0;
R=chi*(mu*r.R101+r.R100)+zeta*(1/mu*r.R011+r.R010)+r.R000;
S=zeta*(1/mu*s.S011+s.S010)+s.S000;
%M=load('Matrix_M.mat').M0;
%R=chi*r.R10+z*r.R01+r.R00;
%S=z*s.S1+s.S0;

% % R00=computeSparseR(n, V, W, 0, 0, c);
% % R01=computeSparseR(n, V, W, 0, 1, c)-R00;
% % R10=computeSparseR(n, V, W, 1, 0, c)-R00;
% % save('Matrix_R.mat','n', 'V', 'W', 'c', 'R00','R01','R10');
% % r=load('Matrix_R.mat');
% % 
% % 
% % S0=computeSparseS(n, V, W, 0, 0, c);
% % S1=computeSparseS(n, V, W, 1, 1, c)-S0;
% % save('Matrix_S.mat','n', 'V', 'W', 'c', 'S0','S1');
% % s=load('Matrix_S.mat');
rmpath(folder_name);
end

function [] = Create_Matrix_Helper(n,c)
% n is the number of basis functions
% V is N
% W is total wealth of the system
% chi is chi 
% z is zeta
% c is the wZero parameter in f(theta)

%Compse the name of Matrix M, R, S
    folder_name=strcat('MatV2_',string(n));
    MatrixM=char(strcat(folder_name,'/MatrixM',string(n),'V2.mat'));
    MatrixR=char(strcat(folder_name,'/MatrixR',string(n),'V2.mat'));
    MatrixS=char(strcat(folder_name,'/MatrixS',string(n),'V2.mat'));
%Compute Matrix Components and save
    %M
    M0=computeSparseM(n, c);
    save(MatrixM,'n', 'c', 'M0');
    
    %R computeTempR(n, c, chi, zeta, W, N)
    %Rabc: a is chi, b is zeta, c is mu
    R000=computeTempR(n,c,0,0,1,1);
    TempR1011=computeTempR(n,c,1,0,1,1)-R000;
    TempR1021=computeTempR(n,c,1,0,2,1)-R000;
    R101=TempR1021-TempR1011; 
    R100=TempR1011-R101;
    clearvars TempR1011 TempR1021
    
    TempR0111=computeTempR(n,c,0,1,1,1)-R000;
    TempR0121=computeTempR(n,c,0,1,2,1)-R000;
    R011=2*(TempR0111-TempR0121);
    R010=TempR0111-R011;
    clearvars TempR0111 TempR0121
    
    save(MatrixR,'n','c', 'R000','R100','R101','R010','R011');
    clearvars R000 R100 R101 R010 R011
    
    
    %S: computeTempS(n, c, chi, zeta, W, N)
%     Original:
%     S000=computeTempS(n, c, 0,0,1,1);
%     TempS0111=computeTempS(n, c, 0,1,1,1)-S000;
%     TempS0121=computeTempS(n, c, 0,1,2,1)-S000;
%     S011=2*(TempS0111-TempS0121);
%     S010=TempS0111-S011;
%     save(MatrixS,'n','c', 'S000', 'S011', 'S010')
%     clearvars TempS0111 TempS0121 S011 S010 S000
    
%     New:
    
    %S: computeTempS(n, c, chi, zeta, W, N)
    % S000 For second order derivative
    % S010 For first order derivative L part
    % S011 For first order derivative A & B part
    S000=computeTempS(n, c, 0,0,1,1);
    S010=computeTempL(n, c, 0,1,1,1);
    S011=computeTempS(n, c, 0,1,1,1)-S000-S010;
    fprintf('All Matrix Calced \n')
    
    save(MatrixS,'n','c', 'S000', 'S011', 'S010');
    fprintf('All Matrix Saved \n')
end

function tempR=computeTempR(n, c, chi, zeta, W, N)
    tempR=computeSparseR(n, N, W, chi, zeta, c);
end

function tempS=computeTempS(n, c, chi, zeta, W, N)
    tempS=computeSparseS(n, N, W, chi, zeta, c);
end

function tempL=computeTempL(n, c, chi, zeta, W, N)
    tempL=computeSparseL(n, N, W, chi, zeta, c);
end
