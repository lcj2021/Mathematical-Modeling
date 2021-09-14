 function[vm] = mont_Coverage(times, r, set, rbound)
 %% 计算给定参数条件下的蒙特卡洛对于set色集在r下命中率
hit = 0;
for i = 1 : times
    x = randi([1, 255], 1);     
    y = randi([1, 255], 1);      
    z = randi([1, 255], 1);     

%     lenBase = length(set);
    lenBase = rbound;
    flag = 0;
    for j = 1 : lenBase
        dist = sqrt((x - set(j, 1))^2 + (y - set(j, 2))^2 + (z - set(j, 3))^2);
        if dist <= r
            flag = 1;
            break;
        end
    end
    if flag == 1
        hit = hit + 1;
    end
end
vm = hit / times;
 end