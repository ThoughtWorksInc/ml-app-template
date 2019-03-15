#!/bin/bash
set -e

export RUN_METRICS_TEST='true'
python -m unittest src/test_model_metrics.py