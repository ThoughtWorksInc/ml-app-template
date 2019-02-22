#!/usr/bin/env bash
set -e

if [[ $CI == 'true' ]]; then
  source .venv/bin/activate
fi

export RUN_METRICS_TEST='true'
python -m unittest src/test_model_metrics.py