#!/usr/bin/env bash
set -e

source .venv/bin/activate

echo "Training ML model..."
python src/train.py
echo "Model training complete."