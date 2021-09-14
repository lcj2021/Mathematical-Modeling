clear all;clc;
load greyInput.mat

%% bool 11个供应商240周 是否缺货矩阵
isLack = zeros(11, 240);

for i = 1 : 240
    for j = 1 : 11
        if raw(j, i) > 5000
            isLack(j, i) = 1;
        end
    end
end 

s1 = isLack(1, :);s2 = isLack(2, :);
s3 = isLack(3, :);s4 = isLack(4, :);
s5 = isLack(5, :);s6 = isLack(6, :);
s7 = isLack(7, :);s8 = isLack(8, :);
s9 = isLack(9, :);s10 = isLack(10, :);
s11 = isLack(11, :);

%% 定位8个供应商的缺货周
shortWeek1 = find(s1); shortWeek2 = find(s2);
shortWeek3 = find(s3); shortWeek4 = find(s4);
shortWeek5 = find(s5); shortWeek6 = find(s6);
shortWeek7 = find(s7); shortWeek8 = find(s8);
shortWeek9 = find(s9); shortWeek10 = find(s10);
shortWeek11 = find(s11);

%% 筛出非缺货时期的 order - supply值, 用于正态分布检验
normalWeek1 = getNormalWeek(raw(1, : ), s1);
normalWeek2 = getNormalWeek(raw(2, : ), s2);
normalWeek3 = getNormalWeek(raw(3, : ), s3);
normalWeek4 = getNormalWeek(raw(4, : ), s4);
normalWeek5 = getNormalWeek(raw(5, : ), s5);
normalWeek6 = getNormalWeek(raw(6, : ), s6);
normalWeek7 = getNormalWeek(raw(7, : ), s7);
normalWeek8 = getNormalWeek(raw( 8, : ),  s8);
normalWeek9 = getNormalWeek(raw( 9, : ),  s9);
normalWeek10 = getNormalWeek(raw(10, : ), s10);
normalWeek11 = getNormalWeek(raw(11, : ), s11);

%% 样本数均大于200, 用雅克‐贝拉检验(JB检验), 显著性水平α= 0.05
h = zeros(11, 1);    p = zeros(11, 1);
[h(1), p(1)] = jbtest(normalWeek1(:, 1 ), 0.05);
[h(2), p(2)] = jbtest(normalWeek2(:, 1 ), 0.05);
[h(3), p(3)] = jbtest(normalWeek3(:, 1 ), 0.05);
[h(4), p(4)] = jbtest(normalWeek4(:, 1 ), 0.05);
[h(5), p(5)] = jbtest(normalWeek5(:, 1 ), 0.05);
[h(6), p(6)] = jbtest(normalWeek6(:, 1 ), 0.05);
[h(7), p(7)] = jbtest(normalWeek7(:, 1 ), 0.05);
[h( 8), p( 8)] = jbtest(normalWeek8(:, 1 ), 0.05);
[h( 9), p( 9)] = jbtest(normalWeek9(:, 1 ), 0.05);
[h(10), p(10)] = jbtest(normalWeek10(:, 1 ), 0.05);
[h(11), p(11)] = jbtest(normalWeek11(:, 1 ), 0.05);

%% h值全部为1, 拒绝原假设, 不服从正态分布, 随机值采用平均分布随机数
devi = -9 + (10) * rand(1);


%% 函数 : 获取非缺货时期的order - supply值
function [out] = getNormalWeek(in, judge)
    out = [];
    for i = 1 : 240
        if judge(i) == 0
            out = [out ; in(i)];
        end
    end
end