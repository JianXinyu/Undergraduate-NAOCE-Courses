# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:42:01 2017

@author: jianx
"""

import pandas as pd
import numpy as np
from fbprophet import Prophet

renting = pd.read_csv('renting.csv')
renting['y'] = np.log(renting['y'])
renting.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(renting);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=1095)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='renting');
m.plot_components(forecast);