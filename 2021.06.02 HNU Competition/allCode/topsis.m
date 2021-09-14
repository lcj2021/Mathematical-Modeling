clear;clc
load X.mat
Sensitivity_analysis = []

%%  ��ʼ������
[n,m] = size(X);

% disp([ num2str(n) '��������Ŀ, ' num2str(m) '������ָ��']) 

%% ���о���������,ֱ�ӽ��б�׼��
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);

%% ö��Ȩ��
for i = 1 : 9
% ����Ȩ��
    weight = [i, 10 - i] / 10;

% ���������ֵ�ľ������Сֵ�ľ��룬������÷�
    D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ �����ֵ�ľ�������
    D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- ����Сֵ�ľ�������
    S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
    stand_S = S / sum(S)
    [sorted_S,index] = sort(stand_S ,'descend')
    Sensitivity_analysis = [Sensitivity_analysis; [i, index(1, 1)]];
end
% plot(Sensitivity_analysis( : , 2), 'bo-')

