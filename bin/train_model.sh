#!/bin/bash
set -e

echo "Training ML model..."
python src/train.py
echo "Model training complete."