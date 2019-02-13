#!/usr/bin/env bash
set -e

# create virtual environment
python3 -m venv .venv

# activate virtual environment
source .venv/bin/activate

# install dependencies in virtual environment
pip install -r requirements.txt