clc, clear
load("Sensitivity_analysis.mat", "Sensitivity_analysis");
plot(Sensitivity_analysis(: , 2), 'bo-')
% xlim([1, 46])
ylim([0, 42])
xlabel('Ȩ��')
ylabel('�������ɫ��')
xticklabels({'1:9', '2:8', '3:7', '4:6', '5:5', '6:4', '7:3', '8:2', '9:1'});
legend('����Ȩ�ص������ȷ���')
grid