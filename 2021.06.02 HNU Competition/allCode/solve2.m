clear;
global set
% load("base.mat", "base");
% load("raw.mat", "raw");
% load("addition.mat", "addition");
%%����������     setΪ�������  addition:+45ɫ  base+10ɫ  raw+0ɫ
% set = addition;
numOfChromosome = 100;
numOfGene = 24;
iterationNum = 150;
[bestChromosome, fitnessBest] = GA(numOfChromosome,numOfGene,iterationNum);

numList=2.^(7 : -1 : 0);    %������Ȩ�ر�
x = sum(bestChromosome(1 : 8) .* numList);
y = sum(bestChromosome(9 : 16) .* numList);
z = sum(bestChromosome(17 : 24) .* numList);