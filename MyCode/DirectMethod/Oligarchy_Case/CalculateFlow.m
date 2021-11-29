function [AgentFlow,WealthFlow,interval, x] = CalculateFlow(Qflow, gamma, real_wealth_axis)
%CALCULATEFLOW from Flow_Orig_20XX
%AgentFlow,WealthFlow: the flow of agent and wealth
%interval: interval of Real wealth
%x       : interval of real wealth
n=size(real_wealth_axis);
n=n(2);
interval=0:1/n:1;
flow1=[0 Qflow'];
flow2= flow1.* real_wealth_axis;
MAA = makima(interval(1:n),flow1);
MAW = makima(real_wealth_axis,flow2);
pdfA=@(x) ppval(MAA, x);
pdfW=@(x) ppval(MAW, x);
AgentFlow=zeros(n,1);
WealthFlow=zeros(n,1);
for i=1:n
    %r=(i-1)/n;
    AgentFlow(i)= integral(pdfA, interval(1), interval(i));
    WealthFlow(i)=integral(pdfW, real_wealth_axis(1), real_wealth_axis(i));
end
AgentFlow=gamma*AgentFlow;
WealthFlow=gamma*WealthFlow;
% save('Flow', 'flow1','AgentFlow', 'WealthFlow', 'interval');
%% Plot to 5 mu/ 10 mu
x0=interval(1:(1+0.994*(n+1))); %canonical base
x=log(1-x0)*(-2);
figure;
plot(x, AgentFlow(1:(1+0.994*(n+1))),[0 5],[0 0],'r-.'); xlim([0 5])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of agents')
title('Agent Flow on agent wealth w in [0, 5\mu]')

figure;
plot(x, WealthFlow(1:(1+0.994*(n+1))),[0 5],[0 0],'r-.'); xlim([0 5])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Wealth Flow in proportion of total wealth')
title('Wealth Flow on agent wealth w in [0, 5\mu]')

figure;
plot(x, AgentFlow(1:(1+0.994*(n+1))),[0 10],[0 0],'r-.'); xlim([0 10])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of agents')
title('Agent Flow on agent wealth w in [0, 10\mu]')

figure;
plot(x, WealthFlow(1:(1+0.994*(n+1))),[0 10],[0 0],'r-.'); xlim([0 10])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Wealth Flow in proportion of total wealth')
title('Wealth Flow on agent wealth w in [0, 10\mu]')

end

function AgentFlow=integralA(pdf, r)
    AgentFlow=integral(pdf, 0, r);
end

function WealthFlow=integralW(pdf, r)
    WealthFlow=integral(pdf, 0, r);
end