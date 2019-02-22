#!/usr/bin/env bash
set -e

if [[ $CI == 'true' ]]; then
  # create virtual environment
  python3 -m venv .venv

  # activate virtual environment
  source .venv/bin/activate
fi

# install dependencies
pip install -r requirements.txt