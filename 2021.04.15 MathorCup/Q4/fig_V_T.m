clc;clear;

T = 15 : 0.01 : 25;
V = 0.1 : 0.01 : 0.5;
[T, V] = meshgrid(T, V);
pw = 851.8014 * 55.01664 .* (80 - T) .* V / (528 * 1);
mesh(T, V, pw)
grid on
xlabel("温度 ℃")
ylabel("水速 m/s")
zlabel("散热效率 W")
