function data = TransferData(data,kappa,C0)
%Transfer real wealth Data to cononical form then to [0,1] Domain
if (nargin<3)
    C0=2.0;
end

%Transfer Negative shift by lambda*mean_welth
lambda=kappa/(1-kappa);
mu=mean(data); %mean wealth
data=data+lambda*mu;
data=data/mean(data);  %to canonical
data=fw(data,C0);

end

