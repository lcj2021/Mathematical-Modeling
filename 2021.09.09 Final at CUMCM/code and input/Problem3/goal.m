function out = goal(o)
    load opti1Input
    global w;
    %% C少A多指标 indic1
    indic1 = 0;
    indic1 = indic1 + (o(1)+o(2)+o(6)+o(10)) / (o(7)+o(8)+o(9)+o(11));
    %% 成本指标 indic2
    indic2 = o(1)+o(2)+1.1*o(3)+1.1*o(4)+1.1*o(5)+o(6)+1.2*o(7)+1.2*o(8)+1.2*o(9)+o(10)+1.2*o(11);
    indic2 = indic2 / 21260.15745;
    %% 两者权重为0.25 : 0.75
    out = 0.2 * indic1 + 0.8 * indic2;
end