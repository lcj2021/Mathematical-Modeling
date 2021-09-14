clc, clear
load("Sensitivity_analysis.mat", "Sensitivity_analysis");
plot(Sensitivity_analysis(: , 2), 'bo-')
% xlim([1, 46])
ylim([0, 42])
xlabel('权重')
ylabel('最优添加色数')
xticklabels({'1:9', '2:8', '3:7', '4:6', '5:5', '6:4', '7:3', '8:2', '9:1'});
legend('关于权重的灵敏度分析')
grid