# Provisioning MLFlow

[For workshop facilitators]

Instructions for provisioning MLFlow on kubernetes are in the README of: https://github.com/arunma/mlflow-gcp

Once MLFlow is provisioned, remember to:
- Replace the mlflow tracking server URL in `src/train.py`
- search for `SHOULD_USE_MLFLOW=false` in the codebase and replace it with `SHOULD_USE_MLFLOW=true`