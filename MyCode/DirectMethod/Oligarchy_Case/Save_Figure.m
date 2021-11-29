figure;
l=plot(real_wealth_axis, AgentFlow,[-0.073 15],[0 0],'r-.'); xlim([-0.073 0])
xlabel('Agent Wealth divided by mean wealth (u=w/\mu)')
ylabel('Agent Flow in proportion of total number of Agents')
title('Agent Flow on negative wealth w in [-0.073\mu, 0]')
set(l,{'LineWidth'},{3;1.5})
saveas(gcf,'2013AgentFlow_Neg.png')