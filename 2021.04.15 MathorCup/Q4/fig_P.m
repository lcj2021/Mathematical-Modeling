clc;clear;
t = 1 : 1 : 24

tidalH2 = [0.13	0.132	0.129	0.125	0.121	0.12	0.123	0.135	0.169	0.187	0.202	0.204	0.2	0.185	0.175	0.152	0.125	0.096	0.075	0.07	0.072	0.077	0.092	0.102]
tidalH2 = tidalH2 + 113;
p = 1.025 * 9.8 .* tidalH2;
plot(t, p, "bo-")
grid on
xlabel("时间(h)")
ylabel("水压(kPa)")
axis([1 24, 1133 1139])
legend("4月18日")