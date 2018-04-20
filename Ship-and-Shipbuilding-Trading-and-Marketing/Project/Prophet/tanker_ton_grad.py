# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:50:03 2017

@author: jianx
"""

import pandas as pd
import numpy as np
from fbprophet import Prophet

tanker_ton_grad = pd.read_csv('tanker_ton_grad.csv')
tanker_ton_grad['y'] = np.log(tanker_ton_grad['y'])
tanker_ton_grad.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(tanker_ton_grad);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=1095)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='tanker_ton_grad');
m.plot_components(forecast);