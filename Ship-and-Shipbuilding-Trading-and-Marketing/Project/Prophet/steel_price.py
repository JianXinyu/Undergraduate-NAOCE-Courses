# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:46:34 2017

@author: jianx
"""

import pandas as pd
import numpy as np
from fbprophet import Prophet

steel_price = pd.read_csv('steel_price.csv')
steel_price['y'] = np.log(steel_price['y'])
steel_price.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(steel_price);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='steel_price');
m.plot_components(forecast);