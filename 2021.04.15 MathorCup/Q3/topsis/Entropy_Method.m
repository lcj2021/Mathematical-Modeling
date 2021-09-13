function [W] = Entropy_Method(Z)
    [n,m] = size(Z);
    D = zeros(1,m);  % 初始化保存信息效用值的行向量
    for i = 1:m
        x = Z(:,i); 
        p = x / sum(x);
        % p有可能为0，所以自己定义函数
        e = -sum(p .* mylog(p)) / log(n); % 计算信息熵
        D(i) = 1- e; % 计算信息效用值
    end
    W = D ./ sum(D);  % 将信息效用值归一化，得到权重    
end