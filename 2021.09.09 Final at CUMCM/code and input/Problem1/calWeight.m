clear all;clc
load indicators.mat
%% 二级指标
% 供货能力指标
supply_avgOfBiggest10 = C1(supply_avgOfBiggest10); % 最大供货量(前10平均)
supply_Short = C2(supply_Short);    % 缺货量
supply_std = C3(supply_std);    % 供货稳定性(标准差)

% 合作能力指标
coop_weightedAvgOfCooperate = C4(coop_weightedAvgOfCooperate);% 合作频数
coop_avgDealVolume = C5(coop_avgDealVolume);% 平均交易量

% 发展潜力
potential_coop = C6(potential_coop);    % 合作潜力
potential_supply = C7(potential_supply); % 供货潜力

% 一级指标 , 由二级指标分别合并
supply_indic = [supply_std, supply_Short, supply_avgOfBiggest10];
coop_indic = [coop_weightedAvgOfCooperate, coop_avgDealVolume];
potential_indic = [potential_coop, potential_supply];

%% 计算二级权重
supply_w = entropy(supply_indic);
supply_w = real(supply_w)
coop_w = entropy(coop_indic)
potential_w = entropy(potential_indic)
%% 计算二级指标综合得分
supply_score = supply_indic * supply_w';
coop_score = coop_indic * coop_w';
potential_score = potential_indic * potential_w';

%% 计算一级指标权重
compreh_indic = [supply_score, coop_score, potential_score];
% compreh_weight = entropy(compreh_indic)
compreh_weight = [0.9136 0.7974 0.7049] / sum([0.9136 0.7974 0.7049]);

%% 计算总得分
total_score = compreh_indic * compreh_weight';

%% 倒序排序, 取出前50名
tmp = sort(total_score, "descend");
treshhold = tmp(50);
top50 = [];
for i = 1 : 402
   if total_score(i) >= treshhold
        top50 = [top50; i] ;
   end
end
supplyCapacity = zeros(50, 1);
realProductionCapacity = zeros(50, 1);    %% ABC类型归一化为能够生产的产品量
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

%% 以下为 各二级指标 隶属度函数
function [out] = C1(in) % 最大供货量 
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

function [out] = C2(in)% 缺货量
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

function [out] = C3(in) % 供货稳定性(标准差)
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

function [out] = C4(in) % 合作频数
    out = zeros(402, 1);
    for i = 1 : 402
        if (in(i) <= 2)
            out(i) = 0;
        else
            out(i) = (in(i) - 2) / (48 - 2);
        end
    end
end

function [out] = C5(in) % 平均交易量
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

function [out] = C6(in) % 合作潜力
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

function [out] = C7(in) % 供货潜力
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
%% 计算熵权
    [n, m] = size(in);
    tmp = zeros(1, m);  % 用于保存信息效用值
    for i = 1 : m
        x = in( : , i);  
        p = x / sum(x);
        e = -sum(p .* mylog(p)) / log(n); % 计算信息熵
        tmp(i) = 1 - e; % 计算信息效用值
    end
    out = tmp ./ sum(tmp);  % 信息效用值归一化
end

%% 防止计算log 0 出现 NaN
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