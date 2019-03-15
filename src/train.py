import os
from math import sqrt

import joblib
import mlflow
import numpy as np
import pandas as pd
from sklearn import datasets, metrics
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split

# load data
data = datasets.load_boston()

# preprocess data
x = pd.DataFrame(data.data, columns=data.feature_names)
column_order = x.columns
y = pd.DataFrame(data.target, columns=["MEDV"])
x_train, x_test, y_train, y_test = train_test_split(x, y)

# configure mlflow
mlflow.set_tracking_uri(uri='http://35.240.197.5:5000')
if os.environ.get('CI', '') == 'true':
    mlflow.set_experiment('CI')
else:
    mlflow.set_experiment('dev')

with mlflow.start_run() as run:
    # define hyperparameters
    N_ESTIMATORS = 6
    MAX_DEPTH = 5

    # train model
    model = RandomForestRegressor(n_estimators=N_ESTIMATORS, max_depth=MAX_DEPTH)
    model = model.fit(x_train, y_train.values.ravel())

    # get predictions (for evaluating the model later)
    y_test_pred = model.predict(x_test)

    # log hyperparameters and metrics to mlflow
    mlflow.log_param('n_estimators', N_ESTIMATORS)
    mlflow.log_param('max_depth', MAX_DEPTH)
    rmse = sqrt(metrics.mean_squared_error(y_true=y_test, y_pred=y_test_pred))
    r2_score = metrics.r2_score(y_true=y_test, y_pred=y_test_pred)
    mlflow.log_metric("rmse_validation_data", rmse)
    mlflow.log_metric("r2_score_validation_data", r2_score)

joblib.dump(model, 'models/model.joblib') 
joblib.dump(column_order, 'models/column_order.joblib')
