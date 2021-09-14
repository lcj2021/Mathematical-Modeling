import numpy as np
import matplotlib.pyplot as plt
# x为缺货时间序列
x = [32,92,130,232]
stepRatio = []      
for i in range(len(x)):
    if i == len(x) - 1:
        continue
    stepRatio.append(x[i] / x[i + 1])   # 计算级比
xCumSum = np.cumsum(x)
# 计算GM(1,1)函数参数
B = np.array([-1 / 2 * (xCumSum[i] + xCumSum[i + 1]) for i in range(len(x) - 1)])
B = np.mat(np.vstack((B, np.ones((len(x) - 1,)))).T)
Y = np.mat([x[i + 1] for i in range(len(x) - 1)]).T
t = np.dot(np.dot(B.T.dot(B).I, B.T), Y)
[a, b] = [t[0, 0], t[1, 0]]
aNew, b = x[0] - b / a, b / a

# 预测3周
week = 3
week += len(x)
xPredict = [x[0]]
xPredict = xPredict + [aNew * (np.exp(-a * i) - np.exp(-a * (i - 1))) for i in range(1, week)]
print(xPredict[:])
plt.plot(xPredict)
plt.xlabel('Out of stork at x th time')
plt.ylabel('Out at week y [mt]')
plt.show()