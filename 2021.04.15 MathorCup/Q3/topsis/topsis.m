clc;clear;
load X.mat

%% 判断是否需要正向化
[n,m] = size(X);
Judge = input(['是否需要经过正向化处理，需要请输入1 ，不需要输入0：  ']);

if Judge == 1
    Position = input('请输入需要正向化处理的指标所在的列'); 
    disp('请输入需要处理的这些列的指标类型（1极小型） ')
    Type = input(); 
    for i = 1 : size(Position,2)
        X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));
    end
end

%% 对正向化后的矩阵进行标准化
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);

%% 调用熵权法
if sum(sum(Z<0)) >0   % 如果之前标准化后的Z矩阵中存在负数，则重新对X进行标准化
    for i = 1:n
        for j = 1:m
            Z(i,j) = [X(i,j) - min(X(:,j))] / [max(X(:,j)) - min(X(:,j))];
        end
    end
    disp('X重新进行标准化得到的标准化矩阵Z为:  ')
    disp(Z)
end
weight = Entropy_Method(Z);
disp('熵权法确定的权重为：')
disp(weight)





%% 计算与最大值的距离和最小值的距离，并算出得分
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P+D_N);    % 未归一化的得分
disp('最后的得分为：')
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')

figure(1)
x = [1 : 5];
y = sorted_S(x);
bar(y);
xlabel('材料')
ylabel('得分')
set(gca,'XTickLabel',{'钛合金Ti-6Al-4V','铬镍铁合金625', '纯钛', '70 - 30白铜', '90 - 10白铜'})
set(gca,'YLim',[0 0.05]);%X轴的数据显示范围
grid on
