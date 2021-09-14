clear all;clc
load indicators.mat
%% ����ָ��
% ��������ָ��
supply_avgOfBiggest10 = C1(supply_avgOfBiggest10); % ��󹩻���(ǰ10ƽ��)
supply_Short = C2(supply_Short);    % ȱ����
supply_std = C3(supply_std);    % �����ȶ���(��׼��)

% ��������ָ��
coop_weightedAvgOfCooperate = C4(coop_weightedAvgOfCooperate);% ����Ƶ��
coop_avgDealVolume = C5(coop_avgDealVolume);% ƽ��������

% ��չǱ��
potential_coop = C6(potential_coop);    % ����Ǳ��
potential_supply = C7(potential_supply); % ����Ǳ��

% һ��ָ�� , �ɶ���ָ��ֱ�ϲ�
supply_indic = [supply_std, supply_Short, supply_avgOfBiggest10];
coop_indic = [coop_weightedAvgOfCooperate, coop_avgDealVolume];
potential_indic = [potential_coop, potential_supply];

%% �������Ȩ��
supply_w = entropy(supply_indic);
supply_w = real(supply_w)
coop_w = entropy(coop_indic)
potential_w = entropy(potential_indic)
%% �������ָ���ۺϵ÷�
supply_score = supply_indic * supply_w';
coop_score = coop_indic * coop_w';
potential_score = potential_indic * potential_w';

%% ����һ��ָ��Ȩ��
compreh_indic = [supply_score, coop_score, potential_score];
% compreh_weight = entropy(compreh_indic)
compreh_weight = [0.9136 0.7974 0.7049] / sum([0.9136 0.7974 0.7049]);

%% �����ܵ÷�
total_score = compreh_indic * compreh_weight';

%% ��������, ȡ��ǰ50��
tmp = sort(total_score, "descend");
treshhold = tmp(50);
top50 = [];
for i = 1 : 402
   if total_score(i) >= treshhold
        top50 = [top50; i] ;
   end
end
supplyCapacity = zeros(50, 1);
realProductionCapacity = zeros(50, 1);    %% ABC���͹�һ��Ϊ�ܹ������Ĳ�Ʒ��
typeOfTop50 = zeros(50, 1);
scoreOfTop50 = zeros(50, 1);
load('indicators.mat', 'supply_avgOfBiggest10');
for i = 1 : 50
    typeOfTop50(i) = type(top50(i));
%     supplyCapacity(i) = supply_avgOfBiggest10(top50(i));
%     realProductionCapacity(i) = supplyCapacity(i) / typeOfTop50(i);
    supplyCapacity(i) = supply_avgOfBiggest15(top50(i));
    if supplyCapacity(i) > 6000
        supplyCapacity(i) = 6000;
    end
    realProductionCapacity(i) = supplyCapacity(i) / typeOfTop50(i);
    scoreOfTop50(i) = total_score(top50(i));
end

%% ����Ϊ ������ָ�� �����Ⱥ���
function [out] = C1(in) % ��󹩻��� 
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 5)
            out(i) = 0;
        elseif in(i) <= 500
            out(i) = 1 / (500 * 495) * in(i) ^ 2 - 1 / (500 * 95) * in(i);
        else
            out(i) = 1;
        end
    end
end

function [out] = C2(in)% ȱ����
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 100)
            out(i) = 1;
        elseif in(i) <= 1000
            out(i) = (1000 - in(i)) / (1000 - 100);
        else
            out(i) = 0;
        end 
    end
end

function [out] = C3(in) % �����ȶ���(��׼��)
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 20)
            out(i) = 1;
        elseif in(i) <= 200
            out(i) = (200 - in(i)) / (200 - 20);
        else
            out(i) = 0;
        end
    end
end

function [out] = C4(in) % ����Ƶ��
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 2)
            out(i) = 0;
        else
            out(i) = (in(i) - 2) / (48 - 2);
        end
    end
end

function [out] = C5(in) % ƽ��������
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 10)
            out(i) = 0;
        elseif in(i) <= 1000
            out(i) = 1 / (1000 * 990) * in(i) ^ 2 - 1 / (1000 * 99) * in(i);
        else
            out(i) = 1;
        end
    end
end

function [out] = C6(in) % ����Ǳ��
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 0.9)
            out(i) = 0;
        elseif in(i) <= 2
            out(i) = (in(i) - 0.9) / (2 - 0.9);
        else
            out(i) = 1;
        end
    end
end 

function [out] = C7(in) % ����Ǳ��
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 0.2)
            out(i) = 0;
        elseif in(i) <= 15
            out(i) = (in(i) - 0.2) / (15 - 0.2);
        else
            out(i) = 1;
        end
    end
end 
function [out] = entropy(in)
%% ������Ȩ
    [n, m] = size(in);
    tmp = zeros(1, m);  % ���ڱ�����ϢЧ��ֵ
    for i = 1 : m
        x = in( : , i);  
        p = x / sum(x);
        e = -sum(p .* mylog(p)) / log(n); % ������Ϣ��
        tmp(i) = 1 - e; % ������ϢЧ��ֵ
    end
    out = tmp ./ sum(tmp);  % ��ϢЧ��ֵ��һ��
end

%% ��ֹ����log 0 ���� NaN
function [out] =  mylog(in)      
n = length(in);   
out = zeros(n, 1);   
    for i = 1:n   
        if in(i) == 0   
            out(i) = 0;  
        else
            out(i) = log(in(i));  
        end
    end
end