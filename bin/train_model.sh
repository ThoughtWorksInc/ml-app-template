#!/usr/bin/env bash
set -e

if [[ $CI == 'true' ]]; then
  source .venv/bin/activate
fi

echo "Training ML model..."
python src/train.py
echo "Model training complete."