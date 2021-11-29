% Author: Sheng Xu
% Last Update: Nov, 2019
% This version is desgined to generate data First-Order Pertubation.

function [q0,res, timeStep, T] = FEM_Data_All_q_perturbation(...
    chi0, zeta0, chi1, zeta1, N, W, wZero, numElements, timeStep, timeIters, marker)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Input:
    %       chi0, chi1: parameter for redistribution
    %       zeta0, zeta1: parameter for WAA
    %       N: total number of agents in the system
    %       W: total wealth of the system
    %       wZero: parameter in tranformation function theta = 1 - exp(-w/wZero)
    %       numElements: number of linear basis functions
    %       timeStep: time step for each iteration
    %       timeIters: number of iterations 
    %       fileName: optional parameter. File name to save the final result
    % return: 
    %       q parameters for basis functions
    %
    % Save Matrix Data to disk for future use;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin<11 || marker==0)
        [~,~,~] = Create_Matrix_to_Disk(numElements, N, W, chi0, zeta0, wZero);
end
chi0;
zeta0;
%[q0,T0] = FEM_Data_initial_q_perturbation(chi0, zeta0, N, W, wZero, numElements, 0.0001, 1000000*timeIters,1);
[q0,~]=Read_Coef(chi0, zeta0);

T=timeStep*timeIters;
delta_chi=(chi1-chi0)/T; 
delta_zeta=(zeta1-zeta0)/T;
chi=chi0; zeta=zeta0;
q=q0;
res=zeros(numElements,timeIters);

load('Matrix_M.mat')
load('Matrix_R.mat');
load('Matrix_S.mat');

for time = 1:timeIters
        if (mod(time,100)==0)
            time
        end
        
        chi=chi+timeStep*delta_chi;
        zeta=zeta+timeStep*delta_zeta;
        oldQ = q;
        [sparseM, sparseR, sparseS]=Read_Matrix_from_Disk(chi, zeta, M0, R10, R01, R00, S1, S0);
        sparseTmp = 0.5 * timeStep * (sparseR + reshape(q' * sparseS, numElements, numElements));
        rhs = (sparseM + sparseTmp) * q;
        forwardQ = (sparseM - sparseTmp) \ rhs;

%         count = 0;
%         while ((count < 8) && (norm(forwardQ - q) > (1e-11)))
%             count  = count + 1;
%             q = forwardQ;
%             forwardQ = (sparseM - 0.5 * timeStep * ( sparseR + reshape(q' * sparseS, numElements, numElements))) \ rhs;    
%         end
        
        q = forwardQ;
        res(:,time)=q;
end
save('Result.mat','numElements', 'N', 'W', 'wZero', 'res', 'chi0', 'chi1',...
    'zeta0', 'zeta1','timeStep', 'timeIters', 'q0');