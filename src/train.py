import joblib

import mlflow
from sklearn import datasets
import numpy as np
import pandas as pd
from sklearn import linear_model

boston = datasets.load_boston()

x = pd.DataFrame(boston.data, columns=boston.feature_names)
y = pd.DataFrame(boston.target, columns=["MEDV"])
column_order = x.columns

mlflow.set_tracking_uri(uri='http://35.240.197.5:5000')
mlflow.set_experiment('dev')

with mlflow.start_run() as run:
  lm = linear_model.LinearRegression()
  model = lm.fit(x, y)

  mlflow.log_param("my", "param")
  mlflow.log_metric("rmse", 0.5)

joblib.dump(model, 'models/linear_model.joblib') 
joblib.dump(column_order, 'models/column_order.joblib')
