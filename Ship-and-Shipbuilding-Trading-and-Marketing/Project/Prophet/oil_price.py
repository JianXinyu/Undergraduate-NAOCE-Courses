# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:39:49 2017

@author: jianx
"""

import pandas as pd
import numpy as np
from fbprophet import Prophet

oil_price = pd.read_csv('oil_price.csv')
oil_price['y'] = np.log(oil_price['y'])
oil_price.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(oil_price);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='oil_price');
m.plot_components(forecast);