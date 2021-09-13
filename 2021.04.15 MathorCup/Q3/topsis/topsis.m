clc;clear;
load X.mat

%% �ж��Ƿ���Ҫ����
[n,m] = size(X);
Judge = input(['�Ƿ���Ҫ�������򻯴�����Ҫ������1 ������Ҫ����0��  ']);

if Judge == 1
    Position = input('��������Ҫ���򻯴����ָ�����ڵ���'); 
    disp('��������Ҫ�������Щ�е�ָ�����ͣ�1��С�ͣ� ')
    Type = input(); 
    for i = 1 : size(Position,2)
        X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));
    end
end

%% �����򻯺�ľ�����б�׼��
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);

%% ������Ȩ��
if sum(sum(Z<0)) >0   % ���֮ǰ��׼�����Z�����д��ڸ����������¶�X���б�׼��
    for i = 1:n
        for j = 1:m
            Z(i,j) = [X(i,j) - min(X(:,j))] / [max(X(:,j)) - min(X(:,j))];
        end
    end
    disp('X���½��б�׼���õ��ı�׼������ZΪ:  ')
    disp(Z)
end
weight = Entropy_Method(Z);
disp('��Ȩ��ȷ����Ȩ��Ϊ��')
disp(weight)





%% ���������ֵ�ľ������Сֵ�ľ��룬������÷�
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ �����ֵ�ľ�������
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- ����Сֵ�ľ�������
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
disp('���ĵ÷�Ϊ��')
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')

figure(1)
x = [1 : 5];
y = sorted_S(x);
bar(y);
xlabel('����')
ylabel('�÷�')
set(gca,'XTickLabel',{'�ѺϽ�Ti-6Al-4V','�������Ͻ�625', '����', '70 - 30��ͭ', '90 - 10��ͭ'})
set(gca,'YLim',[0 0.05]);%X���������ʾ��Χ
grid on
