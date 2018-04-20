# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:30:38 2017

@author: jianx
"""
import pandas as pd
import numpy as np
from fbprophet import Prophet

bdi = pd.read_csv('bdi.csv')
bdi['y'] = np.log(bdi['y'])
bdi.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(bdi);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='bdi');
m.plot_components(forecast);