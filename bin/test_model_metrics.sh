#!/usr/bin/env bash
set -e

source .venv/bin/activate

export RUN_METRICS_TEST='true'
python -m unittest src/test_model_metrics.py