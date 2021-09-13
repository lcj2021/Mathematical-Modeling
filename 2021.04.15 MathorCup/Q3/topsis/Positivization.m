function [posit_x] = Positivization(x,type,i)
    if type == 1  %极小型
        posit_x = Min2Max(x);  %调用Min2Max函数来正向化
    end
end