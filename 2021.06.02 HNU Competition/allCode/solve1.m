clear;
load('base.mat')
load('graph1.mat')
load('graph2.mat')
len1 = length(graph1);
len2 = length(graph2);
opt_Eu1 = zeros(len1, 1);
opt_Eu2 = zeros(len2, 1);

optRGB_Eu1 = zeros(len1, 3);
optRGB_Eu2 = zeros(len2, 3);

%% ≈∑ Ωæ‡¿Î
for i = 1 : len1 
    mindist = 1000000000;
    for j = 1 : 22 
        dist = (graph1(i, 1) - base(j, 1)) ^ 2 + (graph1(i, 2) - base(j, 2)) ^ 2 + (graph1(i, 3) - base(j, 3)) ^ 2;
        if dist < mindist
            mindist = dist;
            opt_Eu1(i) = j;
            optRGB_Eu1(i, :) = base(j, :);
        end
    end
end

for i = 1 : len2 
    mindist = 1000000000;
    for j = 1 : 22 
        dist = (graph2(i, 1) - base(j, 1)) ^ 2 + (graph2(i, 2) - base(j, 2)) ^ 2 + (graph2(i, 3) - base(j, 3)) ^ 2;
        if dist < mindist
            mindist = dist;
            opt_Eu2(i) = j;
        end
    end
end