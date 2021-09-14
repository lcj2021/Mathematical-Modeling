clc, clear;
load opti3Input
%% 第w周
w = 1;
attachBOut = [];

for w = 1 : 24
   sMat = [    s(1  ,w)*ones(1,8),s(2  ,w)*ones(1,8),s(3  ,w)*ones(1,8),s(4  ,w)*ones(1,8),s(5  ,w)*ones(1,8),...
            s(6  ,w)*ones(1,8),s(7  ,w)*ones(1,8),s(8  ,w)*ones(1,8),s(9  ,w)*ones(1,8),s(10  ,w)*ones(1,8),];
    bMat = repmat(b(:,w)',1, 10);
    goal = sMat .* bMat ./ type;

    q1 = repmat([1 0 0 0 0 0 0 0], 1, 10);
    q2 = repmat([0 1 0 0 0 0 0 0], 1, 10);
    q3 = repmat([0 0 1 0 0 0 0 0], 1, 10);
    q4 = repmat([0 0 0 1 0 0 0 0], 1, 10);
    q5 = repmat([0 0 0 0 1 0 0 0], 1, 10);
    q6 = repmat([0 0 0 0 0 1 0 0], 1, 10);
    q7 = repmat([0 0 0 0 0 0 1 0], 1, 10);
    q8 = repmat([0 0 0 0 0 0 0 1], 1, 10);

    A = [
    sMat .* q1;
    sMat .* q2;
    sMat .* q3;
    sMat .* q4;
    sMat .* q5;
    sMat .* q6;
    sMat .* q7;
    sMat .* q8;
    ];
     B = [
    6000;
    6000;
    6000;
    6000;
    6000;
    6000;
    6000;
    6000;
    ];

    Aeq=[
        [[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 9)];
        [repmat([0 0 0 0 0 0 0 0], 1, 1),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 8)];
        [repmat([0 0 0 0 0 0 0 0], 1, 2),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 7)];
        [repmat([0 0 0 0 0 0 0 0], 1, 3),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 6)];
        [repmat([0 0 0 0 0 0 0 0], 1, 4),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 5)];
        [repmat([0 0 0 0 0 0 0 0], 1, 5),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 4)];
        [repmat([0 0 0 0 0 0 0 0], 1, 6),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 3)];
        [repmat([0 0 0 0 0 0 0 0], 1, 7),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 2)];
        [repmat([0 0 0 0 0 0 0 0], 1, 8),[1 1 1 1 1 1 1 1],repmat([0 0 0 0 0 0 0 0], 1, 1)];
        [repmat([0 0 0 0 0 0 0 0], 1, 9),[1 1 1 1 1 1 1 1]];
    ];

    beq = [
        1;
        1;
        1;
        1;
        1;
        1;
        1;
        1;
        1;
        1;
    ];

    intcon = 1:80;
    lb=zeros(1,80);
    ub=ones(1,80);
    [x,y]=intlinprog(goal,intcon,A, B,Aeq,beq,lb,ub);
    x = reshape(x,[8,10]),y ;
    sAtWeekW = s(:, w)';
    sAtWeekW = repmat(sAtWeekW, 8, 1);
    attachBOut = [attachBOut, (sAtWeekW .* x)'];     %% 附件B的输出结果
end

% for j = 1 : 8 : 192
%     attachBOutput = [attachBOutput, sum(attachBOut(:, j : j + 7), 2)];
% end