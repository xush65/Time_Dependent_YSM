function [pre_res, chi0, zeta0, chi1, zeta1]=Run_Optimizer_xzr(pathname, N, W, wZero, numElements, timeStep, timeIters, numIter)
    %% Run the Optimizer of chi, zeta, gamma 
    %% numIter times; 
    %% With random chi0, chi1, zeta0, zeta1
    %% Save the result
    
    % Set Default Value:
    t = datetime('now','Format','yyyyMMdd''_T''HHmmss');
    FileName=['Output',char(t),'.mat'];
    matfile = fullfile(pathname, FileName);
    pre_res=zeros(11,1)';
 
    if (nargin<8)
        numIter=5;
    end
    if (nargin<6)
        timeStep=0.002;
        timeIters=500;
    end
    
    if (nargin<5)
        numElements=799;
    end
    
    if (nargin==1)
        N=1; W=1; wZero=2;
    end
    
    for i=1.0:0.1:1.1
        chi0=i; zeta0=1;
        chi1= chi0+1*(1-2*rand())/100*chi0;
        zeta1=zeta0+1*(1-2*rand())/100*zeta0;
        if (chi1<zeta1)
            tmp=zeta1;
            zeta1=chi1;
            chi1=tmp;
        end
        %chi0=1;zeta0=1; chi1=1.01; zeta1=1.01;
        chi0, zeta0, chi1, zeta1
        [q0,~, ~, T] = FEM_Data_All_q_perturbation(...
                                chi0, zeta0, chi1, zeta1, N, W, wZero, ...
                                numElements, timeStep, timeIters, i);

        % load saved data                   
        load('Result.mat'); load('Matrix_S.mat');load('Matrix_R.mat');
        load('Matrix_M.mat'); load ('Result.mat')
        
        %%pick 5 random time interval mid_point 
        for j=1:5
            m=size(res, 2); rd=randi([0.4*m,0.6*m]);
            l=rd-fix(0.1*m);r=rd+fix(0.1*m);
            chi_init=chi0+(chi1-chi0)*l/m;
            zeta_init=zeta0+(zeta1-zeta0)*l/m;
            %[q_init,~] = FEM_Data_initial_q_perturbation(chi_init, zeta_init, N, W, wZero, ...
            %    numElements, timeStep, timeIters, 1, q0);
            [q_init,~] = Read_Coef(chi_init, zeta_init);
            delta_q=(res(:,r)-res(:,l));
            
            MT=[M0*delta_q, -R01*q_init, -R10*q_init-reshape(q_init' * S1, numElements, numElements)*q_init];
            rhs=(R00+chi_init*R01+zeta_init*R10)*delta_q...
                +reshape(q_init' * S0, numElements, numElements)*delta_q...
                +reshape(delta_q' * S0, numElements, numElements)*q_init...
                +zeta_init*reshape(q_init' * S1, numElements, numElements)*delta_q...
                +zeta_init*reshape(delta_q' * S1, numElements, numElements)*q_init;
            %% Unconstrained
            %%%a=MT\rhs;
            
            %% Constrained
            a=Constrained_Opt(MT, rhs);
           
           %%
            %%%a0 is 1/t; a1 is x; a2 is z
            a(4:11)=[chi0,zeta0, chi1, zeta1, timeIters, timeStep, l, r];
        
            pre_res = vertcat(pre_res,a');
            save(matfile,'pre_res');
        end 
        
    end