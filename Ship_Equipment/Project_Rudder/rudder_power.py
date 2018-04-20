import numpy as np
import matplotlib.pyplot as plt
from sympy import *
# 定义x、y散点坐标
x = np.arange(0, 50, 5)
num = [0, 5566.274063, 13291.39355, 23453.85303, 38367.59605, 50894.43916, 66265.30502, 85010.81834, 89262.6558,
       89819.5445]
y = np.array(num)

# 用3次多项式拟合
f1 = np.polyfit(x, y, 6)
p1 = np.poly1d(f1)
print(p1)

# 也可使用yvals=np.polyval(f1, x)
yvals = p1(x)  # 拟合y值

# 绘图
plot1 = plt.plot(x, y, 's', label='Angle')
plot2 = plt.plot(x, yvals, 'r', label="M(N*m)")
plt.xlabel('Angle')
plt.ylabel('M')
plt.legend(loc=4)  # 指定legend的位置右下角
plt.title('Servo Power')
plt.show()
plt.savefig('Servo_Power')

init_printing()
x = symbols('x')
S = 0.0001492 * x**6 - 0.02077 * x**5 + 1.027 * x**4 - 23.06 * x**3 + 281.8 * x**2 + 33.11 * x + 120.1
print("the Integration is: %f"% integrate(S, (x, 0, 35)))