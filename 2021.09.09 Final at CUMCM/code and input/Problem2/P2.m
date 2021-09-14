clear all; clc;
data1 = xlsread('order.xlsx');
data2 = xlsread('supply.xlsx');

type = data1( : , 241);
data1 = data1( : , 1 : 240);


expProducttionPerWeek = zeros(240, 1);
realProductionPerWeek = zeros(240, 1);

for i = 1 : 240
    tmp1 = 0;
    tmp2 = 0;
    for j = 1 : 402
        tmp1 = tmp1 + data1(j, i) / type(j);
        tmp2 = tmp2 + data2(j, i) / type(j);
    end
    expProducttionPerWeek(i) = tmp1;
    realProductionPerWeek(i) = tmp2;
end


