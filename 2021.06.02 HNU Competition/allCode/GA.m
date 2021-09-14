function [bestChromosome,fitnessBest]=GA(numOfChromosome,numOfGene,iterationNum)
%% 随机生成初始种群，种群大小为numOfChromosome，染色体中基因数为numOfGene
% 进度条
bar = waitbar(0,'进度条')
lastPopulation = randi([0, 1], numOfChromosome, numOfGene);
newPopulation = zeros(numOfChromosome, numOfGene);

%% 最大迭代次数iterationNum
for iteration = 1 : iterationNum
    waitbar(iteration / iterationNum,bar) 
    %% 计算所有numOfChromosome个个体（染色体）的适应度值
    fitnessAll = zeros(1,numOfChromosome);
    for i = 1 : numOfChromosome
        individual = lastPopulation(i,:);
        fitnessAll(i) = fitnessFunc(individual);
    end
    
    %% 如果达到最大迭代次数，跳出变异遗传
    if iteration == iterationNum
        break;
    end
    
    %% 使用轮盘赌法选择numOfChromosome条染色体，种群中个体总数不变
    fitnessSum = sum(fitnessAll);
    fitnessProportion = fitnessAll / fitnessSum;
    % 使用随机数进行numOfChromosome次选择，保持种群中个体数量不变
    for i=1 : numOfChromosome
        probability = rand(1);
        proportionSum = 0;
        chromosomeIndex = 1;
        for j = 1 : numOfChromosome
            proportionSum = proportionSum + fitnessProportion(j);
            if proportionSum >= probability
                chromosomeIndex = j;
                break;
            end
        end
        newPopulation(i,:) = lastPopulation(chromosomeIndex, : );
    end

    %% 将染色体进行配对，执行单点交叉
    lastPopulation=newPopulation;
    % 生成从1到numOfChromosome的无序排列，每两个相邻数字进行配对
    coupleAllIndex = randperm(numOfChromosome);
    for i=1:floor(numOfChromosome/2)
        coupleOneIndex=coupleAllIndex(2*i-1:2*i);
        % 两条染色体交叉的概率
        probability=0.5;
        if rand(i)<probability
            crossPosition=randi([1,numOfGene],1);
            
            newPopulation(coupleOneIndex(1),crossPosition:end)=lastPopulation(coupleOneIndex(2),crossPosition:end);
            newPopulation(coupleOneIndex(2),crossPosition:end)=lastPopulation(coupleOneIndex(1),crossPosition:end);
        end
    end

    %% 对每条染色体执行基本位变异操作
    lastPopulation = newPopulation;
    for i = 1:numOfChromosome
        % 染色体变异的概率
        probability = 0.2;
        if rand(i) < probability
            mutatePosition = randi([1, numOfGene], 1);
            
            % 将对应基因位置的二进制数反转
            if(lastPopulation(i,mutatePosition) == 0)
                newPopulation(i,mutatePosition) = 1;
            else
                newPopulation(i,mutatePosition) = 0;
            end
        end
    end 
    
    %% 迭代完毕，更新种群
    lastPopulation = newPopulation;
end

%% 遗传迭代结束后，获得最优适应度值和对应的基因
fitnessBest = max(fitnessAll);
bestChromosome = newPopulation(find(fitnessAll == fitnessBest, 1), : );
end