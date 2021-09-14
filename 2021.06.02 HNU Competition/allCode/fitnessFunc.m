function fitness=fitnessFunc(chromosome)
%% 选择该色到set色集的所有点距离的最小值作为个体的适应度
global set
%% 计算染色体表现型 24个2进制数 转 3个十进制数xyz坐标
len=length(chromosome); 
numList=2.^(len / 3 -1 : -1 : 0);   %二进制权重表
x = sum(chromosome(1 : 8) .* numList);
y = sum(chromosome(9 : 16) .* numList);
z = sum(chromosome(17 : 24) .* numList);
r = 30;
% 若点落在在边界, 不纳入考虑
if abs(x - 0) < r || abs(x - 255) < r || abs(y - 0) < r || abs(y - 255) < r || abs(z - 0) < r || abs(z - 255) < r
    fitness = -1;
else
    % 计算表现型对应的适应度
    lenBase = length(set);
    dist = zeros(lenBase, 1);
    % 选择该色到set色集的所有点距离的最小值作为个体的适应度
    for i = 1 : lenBase
        dist(i, 1) = sqrt((x - set(i, 1))^2 + (y - set(i, 2))^2 + (z - set(i, 3))^2);
    end
    fitness = min(dist);
end

end
