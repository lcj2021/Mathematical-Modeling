clear;clc
load X.mat
Sensitivity_analysis = []

%%  初始化参数
[n,m] = size(X);

% disp([ num2str(n) '个评价项目, ' num2str(m) '个评价指标']) 

%% 评判矩阵已正向化,直接进行标准化
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);

%% 枚举权重
for i = 1 : 9
% 设置权重
    weight = [i, 10 - i] / 10;

% 计算与最大值的距离和最小值的距离，并算出得分
    D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
    D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
    S = D_N ./ (D_P+D_N);    % 未归一化的得分
    stand_S = S / sum(S)
    [sorted_S,index] = sort(stand_S ,'descend')
    Sensitivity_analysis = [Sensitivity_analysis; [i, index(1, 1)]];
end
% plot(Sensitivity_analysis( : , 2), 'bo-')

