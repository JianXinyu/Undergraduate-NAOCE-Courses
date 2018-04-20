# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 22:30:38 2017

@author: jianx
"""

import pandas as pd
import numpy as np
from fbprophet import Prophet

file_list = [
 'bdi',
 'bcti',
 'bdti',
 'tanker_number',
 'tanker_ton',
 'tanker_number_grad',
 'tanker_ton_grad',
 'oil_price',
 'steel_price',
 'renting',
 'nasdaq',
 'sp500'
]

for i in file_list[3:5]:
	print('现在进行文件：', i, '.csv')

	bdi = pd.read_csv(i+'.csv')
#	bdi = bdi.iloc[:-370, :]	#减去后面的370个数据
	bdi['y'] = np.log(bdi['y'])
	bdi.head()

	# 将数据框导入Prophet模型
	m = Prophet()
	m.fit(bdi)

	# 预测，将结果放入forecast数据框
	future = m.make_future_dataframe(periods=365*3+975)
	forecast = m.predict(future)
	forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

	# 按forecast数据框绘图
	#m.plot(forecast,xlabel='date',ylabel=i)
	#m.plot_components(forecast)

	forecast.to_csv('2020'+i+'.csv')
	print('存储到了：', '2020'+i+'.csv')


print('END!!!')
