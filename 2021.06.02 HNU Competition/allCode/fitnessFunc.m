function fitness=fitnessFunc(chromosome)
%% ѡ���ɫ��setɫ�������е�������Сֵ��Ϊ�������Ӧ��
global set
%% ����Ⱦɫ������� 24��2������ ת 3��ʮ������xyz����
len=length(chromosome); 
numList=2.^(len / 3 -1 : -1 : 0);   %������Ȩ�ر�
x = sum(chromosome(1 : 8) .* numList);
y = sum(chromosome(9 : 16) .* numList);
z = sum(chromosome(17 : 24) .* numList);
r = 30;
% ���������ڱ߽�, �����뿼��
if abs(x - 0) < r || abs(x - 255) < r || abs(y - 0) < r || abs(y - 255) < r || abs(z - 0) < r || abs(z - 255) < r
    fitness = -1;
else
    % ��������Ͷ�Ӧ����Ӧ��
    lenBase = length(set);
    dist = zeros(lenBase, 1);
    % ѡ���ɫ��setɫ�������е�������Сֵ��Ϊ�������Ӧ��
    for i = 1 : lenBase
        dist(i, 1) = sqrt((x - set(i, 1))^2 + (y - set(i, 2))^2 + (z - set(i, 3))^2);
    end
    fitness = min(dist);
end

end
