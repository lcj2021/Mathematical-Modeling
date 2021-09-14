clear;
load('base.mat')
load('graph1.mat')
len1 = length(graph1);
opt_Eu1 = zeros(len1, 1);

Dist_Eu1 = zeros(22, 1);
variance = zeros(22, 1);
optRGB_Eu1 = zeros(len1, 3);


%% ≈∑ Ωæ‡¿Î
i = 1;
mindist = 1000000000;
for j = 1 : 22 
    dist = (graph1(i, 1) - base(j, 1)) ^ 2 + (graph1(i, 2) - base(j, 2)) ^ 2 + (graph1(i, 3) - base(j, 3)) ^ 2;
    Dist_Eu1(j) = dist;
    variance(j) = std(graph1(i, :) - base(j, :));
end