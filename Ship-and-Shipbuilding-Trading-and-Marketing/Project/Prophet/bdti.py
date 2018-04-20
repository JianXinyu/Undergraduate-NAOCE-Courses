# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 12:35:10 2017

@author: jianx
"""
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from fbprophet import Prophet

# 用csv建立数据框，转为对数坐标
#df = pd.read_csv('DATA2.csv')
bdti = pd.read_csv('bdti.csv')
#bdti1 = bdti.iloc[:, :len(bdti)-365]
bdti['y'] = np.log(bdti['y'])
bdti.head()

# 将数据框导入Prophet模型
#set uncertainty interval, 80% by default
#do full Bayesian sampling, 0 by default, to get uncertainty in seasonality, causes much more time 
#m = Prophet(interval_width=0.95,mcmc_samples=300) 
m=Prophet()
m.fit(bdti)

# 预测，将结果放入forecast数据框
future = m.make_future_dataframe(periods=365*3)
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

# 按forecast数据框绘图
#plt.figure(figsize=(20,8),dpi=200)
m.plot(forecast,xlabel='date',ylabel='bdti')
m.plot_components(forecast);
m.predictive_samples(future)


#plt.figure(figsize=(20,10))
#plt.scatter(df['ds'],df['y'])
#plt.show()


