function [posit_x] = Positivization(x,type,i)
    if type == 1  %��С��
        posit_x = Min2Max(x);  %����Min2Max����������
    end
end