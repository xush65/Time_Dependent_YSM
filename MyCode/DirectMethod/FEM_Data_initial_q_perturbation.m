% Author: Sheng Xu
% Last Update: Nov, 2019
% This version is desgined to generate data First-Order Pertubation.

function [q,T] = FEM_Data_initial_q_perturbation(chi, zeta, N, W, wZero, ...
                 numElements, timeStep, timeIters, marker, q)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Input:
    %       chi: parameter for redistribution
    %       zeta: parameter for WAA
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
    
     % Turn off warnings
    warning('off','all');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Set parameters for FEM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % c0 is the fraction of wealth held by wealthest agent in the system
    
    c0 = 0.00;
   % load initial condition
    load('initialCondition1.mat');

    initW = (W * (1 - c0)/N) * init_w;
    initP = (N^2/(W * (1 - c0))) * init_P;
    %initial q
    %q = computeInitQ(numElements, initW, initP, wZero);
    
    if (nargin<10)
        load('initialConditions.mat');
    end
    
    if (nargin<9 || marker==0)
        [sparseM, sparseR, sparseS] = Create_Matrix_to_Disk(numElements, ...
                                    N, W, chi, zeta, wZero);
 
    else
        disp('Read Matrix from Disk!')
        [sparseM, sparseR, sparseS]=Read_Matrix_from_Disk(numElements, N, W, chi, zeta, wZero);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Start time iteration
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    T = timeIters * timeStep;
    
    for time = 1:timeIters 
%         if (mod(time,1000)==0)
%             time
%             tmp=q(numElements)
%         end
        oldQ = q;
        
        sparseTmp = 0.5 * timeStep * (sparseR + reshape(q' * sparseS, numElements, numElements));
        rhs = (sparseM + sparseTmp) * q;
        forwardQ = (sparseM - sparseTmp) \ rhs;

        count = 0;
        while ((count < 8) && (norm(forwardQ - q) > (1e-11)))
            count  = count + 1;
            q = forwardQ;
            forwardQ = (sparseM - 0.5 * timeStep * ( sparseR + reshape(q' * sparseS, numElements, numElements))) \ rhs;    
        end
        
        q = forwardQ;
        if (max(abs(forwardQ - oldQ)) < 0.000001)
            T = time * timeStep;
            break;
        end  
        
    end
    
    
%    save(strcat('q',num2str(chi),'-',num2str(zeta),'.mat'),'q','T','-v7.3');
%    save(strcat('T',num2str(chi),'-',num2str(zeta),'.mat'),'T');
%    if exist('fileName', 'var') 
%        aaa.(strcat('q', int2str(fileName)))=q;
%        save(strcat('q', int2str(fileName), '.mat'), '-struct', 'aaa', strcat('q', int2str(fileName)));
%    end 

end