clc, clear
load("bestFitness.mat", "bestFitness");
plot(bestFitness, 'bo-')
xlim([1, 45])
ylim([40, 125])
xlabel('颜色添加数')
ylabel('适应度')
legend('适应度')
grid
annotation('textarrow',[0.783214285714286 0.863214285714286],...
    [0.149 0.157619047619048],'String',{'53.1883'});
annotation('textarrow',[0.214642857142857 0.143214285714286],...
    [0.808047619047619 0.837619047619048],'String',{'116.5204'});