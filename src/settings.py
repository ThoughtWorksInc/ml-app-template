import os
# if env != 'dev'
SHOULD_USE_MLFLOW='true'
MLFLOW_IP='35.185.191.70'
PORT=8080

if os.environ.get('GO_PIPELINE_NAME', ''):
  CI=True
# if env == 'CI'...
# if env == 'production'...