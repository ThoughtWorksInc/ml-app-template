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

# train model
print('Training ML model...')
N_ESTIMATORS = 2
MAX_DEPTH = 2
model = RandomForestRegressor(n_estimators=N_ESTIMATORS, max_depth=MAX_DEPTH)
model = model.fit(x_train, y_train.values.ravel())

# save model 
joblib.dump(model, 'models/model.joblib') 
joblib.dump(column_order, 'models/column_order.joblib')

if os.environ.get('SHOULD_USE_MLFLOW', '') == 'true':
    # log training run to mlflow
    mlflow.set_tracking_uri(uri='http://35.240.197.5:5000')
    if os.environ.get('CI', '') == 'true':
        mlflow.set_experiment('CI')
    else:
        mlflow.set_experiment('dev')

    with mlflow.start_run() as run:
        # calculate evaluation metrics
        y_test_pred = model.predict(x_test)
        rmse = sqrt(metrics.mean_squared_error(y_true=y_test, y_pred=y_test_pred))
        r2_score = metrics.r2_score(y_true=y_test, y_pred=y_test_pred)

        # log hyperparameters to mlflow
        mlflow.log_param('n_estimators', N_ESTIMATORS)
        mlflow.log_param('max_depth', MAX_DEPTH)
        
        # log metrics to mlflow
        mlflow.log_metric("rmse_validation_data", rmse)
        mlflow.log_metric("r2_score_validation_data", r2_score)
else:
    print('Not logging training run because MLFlow tracking server is not up, or its URL is not set in train.py')