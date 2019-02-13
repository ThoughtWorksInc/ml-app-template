import os
import joblib
import mlflow
from math import sqrt
import numpy as np
import pandas as pd
from sklearn import datasets
from sklearn import linear_model
from sklearn import metrics 
from sklearn.model_selection import train_test_split


# load data
boston = datasets.load_boston()

# preprocess data
x = pd.DataFrame(boston.data, columns=boston.feature_names)
column_order = x.columns
y = pd.DataFrame(boston.target, columns=["MEDV"])
x_train, x_test, y_train, y_test = train_test_split(x, y)

# configure mlflow
mlflow.set_tracking_uri(uri='http://35.240.197.5:5000')
if os.environ.get('CI', '') == 'true':
  mlflow.set_experiment('CI')
else:
  mlflow.set_experiment('dev')

with mlflow.start_run() as run:
  lm = linear_model.LinearRegression()
  model = lm.fit(x_train, y_train)

  y_test_pred = model.predict(x_test)
  
  mlflow.log_metric("rmse", sqrt(metrics.mean_squared_error(y_true=y_test, y_pred=y_test_pred)))
  mlflow.log_metric("r2_score", metrics.r2_score(y_true=y_test, y_pred=y_test_pred))

joblib.dump(model, 'models/linear_model.joblib') 
joblib.dump(column_order, 'models/column_order.joblib')
