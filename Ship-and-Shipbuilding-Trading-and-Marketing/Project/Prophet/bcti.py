# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:31:52 2017

@author: jianx
"""
import pandas as pd
import numpy as np
from fbprophet import Prophet

#bcti = pd.read_csv('bcti1.csv')
bcti = pd.read_csv('bcti.csv')
bcti['y'] = np.log(bcti['y'])
bcti.head()

# 将数据框导入Prophet模型
m = Prophet()
m.fit(bcti);

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
m.plot(forecast,xlabel='date',ylabel='bcti');
m.plot_components(forecast);