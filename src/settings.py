import os
# if env != 'dev'
SHOULD_USE_MLFLOW='true'
MLFLOW_IP='35.185.191.70'
PORT=8080

# CI is defined as 'true' in ci.gocd.yaml
CI=os.environ.get('CI', '')
# if env == 'CI'...
# if env == 'production'...