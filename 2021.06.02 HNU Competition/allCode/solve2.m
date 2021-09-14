clear;
global set
% load("base.mat", "base");
% load("raw.mat", "raw");
% load("addition.mat", "addition");
%%参数设置区     set为计算对象  addition:+45色  base+10色  raw+0色
% set = addition;
numOfChromosome = 100;
numOfGene = 24;
iterationNum = 150;
[bestChromosome, fitnessBest] = GA(numOfChromosome,numOfGene,iterationNum);

numList=2.^(7 : -1 : 0);    %二进制权重表
x = sum(bestChromosome(1 : 8) .* numList);
y = sum(bestChromosome(9 : 16) .* numList);
z = sum(bestChromosome(17 : 24) .* numList);