% theta=0:(1/n):1;
% w=-2*log(1-theta(1:n))-0.073;

n=size(real_wealth_axis);
n=n(2);

%% Negative Wealth
figure;
l=plot(real_wealth_axis, AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([-0.073 0])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of Agents')
title('Agent Flow on negative wealth w in [-0.073\mu, 0]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013AgentFlow_Neg.png')

figure;
l=plot(real_wealth_axis, WealthFlow,[-0.073 15],[0 0],'r-.'); xlim([-0.073 0])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Wealth Flow in proportion of total wealth')
title('Wealth Flow on negative wealth w in [-0.073\mu 0]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_Neg.png')

figure;
l=plot(real_wealth_axis, WealthFlow-real_wealth_axis'.* AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([-0.073 0])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('J_W(w) - w J_N(w) in proportion of total wealth')
title('Adjusted Wealth Flow Adjusted on w in [-0.073\mu 0]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_Adjusted_Neg.png')
%% Positive wealth below mean
figure;
l=plot(real_wealth_axis, AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([0 1])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of Agents')
title('Agent Flow on agent wealth w in [0,\mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013AgentFlow_LowPos.png')

figure;
l=plot(real_wealth_axis, WealthFlow,[-0.073 15],[0 0],'r-.'); xlim([0 1])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Wealth Flow in proportion of total wealth')
title('Wealth Flow on agent wealth w in [0, \mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_LowPos.png')

figure;
l=plot(real_wealth_axis, WealthFlow-real_wealth_axis'.* AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([0 1])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('J_W(w) - w J_N(w) in proportion of total wealth')
title('Adjusted Wealth Flow on w in [0, \mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_Adjusted_LowPos.png')

%% Positive wealth
figure;
l=plot(real_wealth_axis, AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([0 10])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of Agents')
title('Agent Flow on agent wealth w in [0, 10\mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013AgentFlow_Pos.png')

figure;
l=plot(real_wealth_axis, WealthFlow,[-0.073 15],[0 0],'r-.'); xlim([0 10])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Wealth Flow in proportion of total wealth')
title('Wealth Flow on agent wealth w in [0, 10\mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_Pos.png')

figure;
l=plot(real_wealth_axis, WealthFlow-real_wealth_axis'.* AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([0 10])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('J_W(w) - w J_N(w) in proportion of total wealth')
title('Adjusted Wealth Flow on w in [0, 10\mu]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013WealthFlow_Adjusted_Pos.png')