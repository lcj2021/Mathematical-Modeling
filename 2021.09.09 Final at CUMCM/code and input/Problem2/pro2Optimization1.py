from platypus import Problem, NSGAII, Constraint, Binary, nondominated, unique

isSelected = 50     # 50个供应商是否选择
treshhold = 70000   #原未来24周预测最大值为59695.72，为保证供货，改为70000

realProduct = [158.5555556,3161.759259,594.1414141,5.454545455,4.888888889,
            1089.69697,845.5555556,12.92929293,6.111111111,1344.259259,
            7380,887.3333333,3.222222222,3563.611111,1283.333333,
            9090.909091,9090.909091,1504.222222,5429.537037,430.6666667,
            753.3333333,8018.555556,615.1111111,857.1296296,13.98148148,
            4278.333333,3.232323232,4.949494949,425.8333333,957.5,
            398.3333333,1480.444444,2415.111111,786.1111111,659,
            1072.685185,8215.222222,2458.787879,1453.666667,3064.545455,
            2502.323232,1548.888889,8162.888889,1059.222222,1851.574074,
            3281.111111,705.7575758,498.7962963,4316.944444,5852.444444]
score = [0.2766,0.3651,0.2809,0.2915,0.2743,0.3747,0.3350,0.3973,0.2911,0.3636,
                0.6248,0.3660,0.3734,0.5516,0.4555,0.5133,0.6180,0.4093,0.6252,0.4389,
                0.4151,0.8807,0.3328,0.4009,0.2582,0.6256,0.2733,0.3384,0.2534,0.4638,
                0.4344,0.5034,0.5386,0.4269,0.3112,0.4582,0.4268,0.5232,0.4872,0.5021,
                0.3687,0.5005,0.4662,0.4069,0.4506,0.6252,0.3738,0.2886,0.5504,0.5928]
    
def pro2Opti1(x):
    selection = x[0]
    # 不等式约束函数
    totalProduct = sum([realProduct[i] if selection[i] else 0 for i in range(isSelected)])   
    # 目标函数2 : 选出供应商的总得分
    totalScore = sum([score[i] if selection[i] else 0 for i in range(isSelected)])   
    # 目标函数1 : 选出供应商的总供应量
    cnt = -sum(selection)               
    return [ cnt, totalScore], [totalProduct]

problem = Problem(1, 2, 1)      # 两个目标函数，一个不等式约束
problem.types[0] = Binary(isSelected)    # 变量类型为2进制
problem.directions[0] = Problem.MAXIMIZE    
problem.constraints[0] = Constraint(">=", treshhold)    # 总供货量 >= 70000
problem.function = pro2Opti1

algorithm = NSGAII(problem)     # 使用NSGAII算法求解多目标线性规划
algorithm.run(50000)

for solution in unique(nondominated(algorithm.result)):     # 返回解集中的非支配解并且去重
    print(solution.variables, solution.objectives)