import joblib

from sklearn import datasets
import numpy as np
import pandas as pd
from sklearn import linear_model

boston = datasets.load_boston()

x = pd.DataFrame(boston.data, columns=boston.feature_names)
y = pd.DataFrame(boston.target, columns=["MEDV"])
column_order = x.columns

lm = linear_model.LinearRegression()
model = lm.fit(x, y)

joblib.dump(model, 'models/linear_model.joblib') 
joblib.dump(column_order, 'models/column_order.joblib') 
