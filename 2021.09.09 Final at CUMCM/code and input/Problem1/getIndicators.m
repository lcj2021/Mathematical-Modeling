clear all;clc

order = xlsread('order.xlsx');
supply = xlsread('supply.xlsx');
%% ���Ԥ���� - ȱʧֵ���
check1 = isnan(order);  check1 = sum(sum(check1)');
check2 = isnan(supply); check2 = sum(sum(check2)');

supply_avgOfBiggest10 = zeros(402, 1);      %%ÿ����Ӧ�� 240�ܹ�Ӧ��ǰʮȡƽ��
supply_avgOfBiggest15 = zeros(402, 1);      %%ÿ����Ӧ�� 240�ܹ�Ӧ��ǰʮȡƽ��
supply_std = zeros(402, 1);                 %%ÿ����Ӧ �̹�����׼��
isCooperate = zeros(402, 240);              %%bool����, �ж�ĳһ����ĳ��Ӧ���Ƿ����
coop_weightedAvgOfCooperate = zeros(402, 1);%%ÿ����Ӧ�� ��3���Ȩ����Ƶ��
coop_avgDealVolume = zeros(402, 1);         %%ÿ����Ӧ�� ƽ��������
supply_Short = zeros(402, 1);               %%ÿ����Ӧ�� 5������ȱ����
potential_coop = zeros(402, 1);             %%ÿ����Ӧ�� ����Ǳ��
potential_supply = zeros(402, 1);           %%ÿ����Ӧ�� ����Ǳ��    


%% ����ѭ�� ����Ϊ ��������
for i = 1 : 402
    % ����ÿ����Ӧ�� 240�ܹ�Ӧ��ǰʮȡƽ��
    tmp = sort (supply(i,  : ), 'descend');
    supply_sumOfBiggest10 = sum(tmp(1 : 10));
    supply_sumOfBiggest15 = sum(tmp(1 : 15));
    supply_avgOfBiggest10(i) = supply_sumOfBiggest10 / 10;
    supply_avgOfBiggest15(i) = supply_sumOfBiggest15 / 15;
    clear tmp, clear supply_sumOfBiggest10;
    
    % ���� 5������ȱ������
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
    
    % �󷽲�
    supply_std(i) = std(supply([supply(i, :) ~= 0]));
end

%% ���� bool - �Ƿ��������
for i = 1 : 402
    
    for j = 1 : 240
        if (supply(i, j) > 0 && order(i, j) > 0)
            isCooperate(i, j) = 1;
        end
    end
end

%% ����ѭ�� ����Ϊ ��������ָ��
for i = 1 : 402
    % ����ÿ����Ӧ�� ��3���Ȩ����Ƶ��
    coop_weightedAvgOfCooperate(i) = sum(isCooperate(i, 97 : 144)) * 0.2 +... 
    sum(isCooperate(i, 145 : 192)) * 0.3 + sum(isCooperate(i, 193 : 240)) * 0.5;
    
    % ����ÿ����Ӧ�� ƽ��������
    tmp = 0;
    for j = 1 : 240
        tmp = tmp + order(i, j) * isCooperate(i, j);
    end
    coop_avgDealVolume(i) = tmp / sum(isCooperate(i, : ));
    clear tmp;
    
end

%% ����ѭ�� ����Ϊ ��չǱ��ָ��
for i = 1 : 402
    % ����ÿ����Ӧ�� ����Ǳ��
    year4 = sum(isCooperate(i, 193 : 240)) / sum(isCooperate(i, 145 : 192));
    if sum(isCooperate(i, 145 : 192)) == 0  
        year4 = sum(isCooperate(i, 193 : 240));
    end
    year5 = sum(isCooperate(i, 145 : 192)) / sum(isCooperate(i, 97 : 144));
    if sum(isCooperate(i, 97 : 144)) == 0  
        year5 = sum(isCooperate(i, 145 : 192));
    end
    potential_coop(i) = 0.5 * (year4 + year5);
    
    % ����ÿ����Ӧ�� ����Ǳ��  
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