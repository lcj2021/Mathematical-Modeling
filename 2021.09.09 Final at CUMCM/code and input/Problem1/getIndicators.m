clear all;clc

order = xlsread('order.xlsx');
supply = xlsread('supply.xlsx');
%% 表格预处理 - 缺失值检查
check1 = isnan(order);  check1 = sum(sum(check1)');
check2 = isnan(supply); check2 = sum(sum(check2)');

supply_avgOfBiggest10 = zeros(402, 1);      %%每个供应商 240周供应量前十取平均
supply_avgOfBiggest15 = zeros(402, 1);      %%每个供应商 240周供应量前十取平均
supply_std = zeros(402, 1);                 %%每个供应 商供货标准差
isCooperate = zeros(402, 240);              %%bool矩阵, 判断某一周与某供应商是否合作
coop_weightedAvgOfCooperate = zeros(402, 1);%%每个供应商 后3年加权合作频数
coop_avgDealVolume = zeros(402, 1);         %%每个供应商 平均交易量
supply_Short = zeros(402, 1);               %%每个供应商 5年内总缺货量
potential_coop = zeros(402, 1);             %%每个供应商 合作潜力
potential_supply = zeros(402, 1);           %%每个供应商 供货潜力    


%% 下列循环 对象为 供货能力
for i = 1 : 402
    % 计算每个供应商 240周供应量前十取平均
    tmp = sort (supply(i,  : ), 'descend');
    supply_sumOfBiggest10 = sum(tmp(1 : 10));
    supply_sumOfBiggest15 = sum(tmp(1 : 15));
    supply_avgOfBiggest10(i) = supply_sumOfBiggest10 / 10;
    supply_avgOfBiggest15(i) = supply_sumOfBiggest15 / 15;
    clear tmp, clear supply_sumOfBiggest10;
    
    % 计算 5年内总缺货数量
    tmp = 0;
    for j = 1 : 240
        if (supply(i, j) >= order(i, j))
            tmp = tmp + 0;
        else
            tmp = tmp + abs(supply(i, j) - order(i, j));
        end
    end
    supply_Short(i) = supply_Short(i) + tmp;
    clear tmp;
    
    % 求方差
    supply_std(i) = std(supply([supply(i, :) ~= 0]));
end

%% 计算 bool - 是否合作矩阵
for i = 1 : 402
    
    for j = 1 : 240
        if (supply(i, j) > 0 && order(i, j) > 0)
            isCooperate(i, j) = 1;
        end
    end
end

%% 下列循环 对象为 合作能力指标
for i = 1 : 402
    % 计算每个供应商 后3年加权合作频数
    coop_weightedAvgOfCooperate(i) = sum(isCooperate(i, 97 : 144)) * 0.2 +... 
    sum(isCooperate(i, 145 : 192)) * 0.3 + sum(isCooperate(i, 193 : 240)) * 0.5;
    
    % 计算每个供应商 平均交易量
    tmp = 0;
    for j = 1 : 240
        tmp = tmp + order(i, j) * isCooperate(i, j);
    end
    coop_avgDealVolume(i) = tmp / sum(isCooperate(i, : ));
    clear tmp;
    
end

%% 下列循环 对象为 发展潜力指标
for i = 1 : 402
    % 计算每个供应商 合作潜力
    year4 = sum(isCooperate(i, 193 : 240)) / sum(isCooperate(i, 145 : 192));
    if sum(isCooperate(i, 145 : 192)) == 0  
        year4 = sum(isCooperate(i, 193 : 240));
    end
    year5 = sum(isCooperate(i, 145 : 192)) / sum(isCooperate(i, 97 : 144));
    if sum(isCooperate(i, 97 : 144)) == 0  
        year5 = sum(isCooperate(i, 145 : 192));
    end
    potential_coop(i) = 0.5 * (year4 + year5);
    
    % 计算每个供应商 供货潜力  
    year4 = sum(supply(i, 193 : 240)) / sum(supply(i, 145 : 192));
    if sum(supply(i, 145 : 192)) == 0  
        year4 = sum(supply(i, 193 : 240));
    end
    year5 = sum(supply(i, 145 : 192)) / sum(supply(i, 97 : 144));
    if sum(supply(i, 97 : 144)) == 0  
        year5 = sum(supply(i, 145 : 192));
    end
    potential_supply(i) = 0.5 * (year4 + year5);
    clear year4, clear year5
end