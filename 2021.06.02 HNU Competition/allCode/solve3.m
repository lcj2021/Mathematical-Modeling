clc, clear;
load("base.mat", "base");
load("raw.mat", "raw");
load("addition.mat", "addition");
load("coverage.mat", "coverage");
res = []

%%参数设置区     set为计算对象  addition:+45色  base+10色  raw+0色
times = 1000000;
r = 40;
set = addition;

for rbound = 22 : 67
    t = mont_Coverage(times, r, set, rbound);
    res = [res; t] 
end

% plot(res, 'bo-');
