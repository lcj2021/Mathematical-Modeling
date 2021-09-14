clc, clear;
global set
load("base.mat", "base");
load("raw.mat", "raw");
load("addition.mat", "addition");
set = addition;
lenBase = length(set);
set = set';

figure(1)

for i = 1 : lenBase
    X = set(1, i);
    Y = set(2, i);
    Z = set(3, i);
    c = [X Y Z] / 255;
    xlim([0 255]);
    ylim([0 255]);
    zlim([0 255]);
    scatter3(X,Y,Z,5000,c,'filled')
    view([-83.0580110497238 34.3275700934579]);
    hold on
end