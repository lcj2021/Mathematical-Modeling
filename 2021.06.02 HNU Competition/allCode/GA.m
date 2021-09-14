function [bestChromosome,fitnessBest]=GA(numOfChromosome,numOfGene,iterationNum)
%% ������ɳ�ʼ��Ⱥ����Ⱥ��СΪnumOfChromosome��Ⱦɫ���л�����ΪnumOfGene
% ������
bar = waitbar(0,'������')
lastPopulation = randi([0, 1], numOfChromosome, numOfGene);
newPopulation = zeros(numOfChromosome, numOfGene);

%% ����������iterationNum
for iteration = 1 : iterationNum
    waitbar(iteration / iterationNum,bar) 
    %% ��������numOfChromosome�����壨Ⱦɫ�壩����Ӧ��ֵ
    fitnessAll = zeros(1,numOfChromosome);
    for i = 1 : numOfChromosome
        individual = lastPopulation(i,:);
        fitnessAll(i) = fitnessFunc(individual);
    end
    
    %% ����ﵽ���������������������Ŵ�
    if iteration == iterationNum
        break;
    end
    
    %% ʹ�����̶ķ�ѡ��numOfChromosome��Ⱦɫ�壬��Ⱥ�и�����������
    fitnessSum = sum(fitnessAll);
    fitnessProportion = fitnessAll / fitnessSum;
    % ʹ�����������numOfChromosome��ѡ�񣬱�����Ⱥ�и�����������
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

    %% ��Ⱦɫ�������ԣ�ִ�е��㽻��
    lastPopulation=newPopulation;
    % ���ɴ�1��numOfChromosome���������У�ÿ�����������ֽ������
    coupleAllIndex = randperm(numOfChromosome);
    for i=1:floor(numOfChromosome/2)
        coupleOneIndex=coupleAllIndex(2*i-1:2*i);
        % ����Ⱦɫ�彻��ĸ���
        probability=0.5;
        if rand(i)<probability
            crossPosition=randi([1,numOfGene],1);
            
            newPopulation(coupleOneIndex(1),crossPosition:end)=lastPopulation(coupleOneIndex(2),crossPosition:end);
            newPopulation(coupleOneIndex(2),crossPosition:end)=lastPopulation(coupleOneIndex(1),crossPosition:end);
        end
    end

    %% ��ÿ��Ⱦɫ��ִ�л���λ�������
    lastPopulation = newPopulation;
    for i = 1:numOfChromosome
        % Ⱦɫ�����ĸ���
        probability = 0.2;
        if rand(i) < probability
            mutatePosition = randi([1, numOfGene], 1);
            
            % ����Ӧ����λ�õĶ���������ת
            if(lastPopulation(i,mutatePosition) == 0)
                newPopulation(i,mutatePosition) = 1;
            else
                newPopulation(i,mutatePosition) = 0;
            end
        end
    end 
    
    %% ������ϣ�������Ⱥ
    lastPopulation = newPopulation;
end

%% �Ŵ����������󣬻��������Ӧ��ֵ�Ͷ�Ӧ�Ļ���
fitnessBest = max(fitnessAll);
bestChromosome = newPopulation(find(fitnessAll == fitnessBest, 1), : );
end