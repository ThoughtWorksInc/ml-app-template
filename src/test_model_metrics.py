import os
import unittest
from math import sqrt

import joblib
import pandas as pd
from sklearn import datasets, metrics


@unittest.skipUnless(os.environ.get('RUN_METRICS_TEST', '') == 'true', 'skip metrics tests when running unit tests')
class TestSimpleExample(unittest.TestCase):
    def setUp(self):
        import warnings
        with warnings.catch_warnings():
            warnings.simplefilter("ignore")
            model = joblib.load(f'./models/model.joblib') 

        data = datasets.load_boston()
        x = pd.DataFrame(data.data, columns=data.feature_names)
        self.y = pd.DataFrame(data.target, columns=["MEDV"])
        self.y_pred = model.predict(x)
    
    
    def test_rmse_should_be_below_5(self):
        rmse = sqrt(metrics.mean_squared_error(y_true=self.y, y_pred=self.y_pred))
        self.assertLessEqual(rmse, 6)

    def test_r2_score_should_be_above_0_point_8(self):
        r2 = metrics.r2_score(y_true=self.y, y_pred=self.y_pred)
        self.assertGreaterEqual(r2, 0.5)