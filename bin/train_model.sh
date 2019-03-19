#!/bin/bash
set -e

SHOULD_USE_MLFLOW=false python src/train.py
echo "Model training complete."