%% A routine to read and process data for perturbation between 
%% 2013 and 2016
US2013=ReadDataUS(2013);
US2016=ReadDataUS(2016);
C0=1/2.0;
US16T=TransferData(US2016,0.058,C0);
US13T=TransferData(US2013,0.078,C0);

%% Truncate: eliminate <0;
US16TT=US16T(US16T>=0 & US16T<=1); 
US13TT=US13T(US13T>=0 & US13T<=1);

%% Transfer to FEM Basis
US16FEM=DataToFEM(US16TT,99,9999);
US13FEM=DataToFEM(US13TT);