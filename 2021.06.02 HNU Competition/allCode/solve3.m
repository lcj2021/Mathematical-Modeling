clc, clear;
load("base.mat", "base");
load("raw.mat", "raw");
load("addition.mat", "addition");
load("coverage.mat", "coverage");
res = []

%%����������     setΪ�������  addition:+45ɫ  base+10ɫ  raw+0ɫ
times = 1000000;
r = 40;
set = addition;

for rbound = 22 : 67
    t = mont_Coverage(times, r, set, rbound);
    res = [res; t] 
end

% plot(res, 'bo-');
