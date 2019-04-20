#!/bin/bash
set -e

export RUN_METRICS_TEST='true'
python -m unittest src/tests/test_model_metrics.py