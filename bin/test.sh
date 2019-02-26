#!/bin/bash

if [[ $CI == 'true' ]]; then
  source .venv/bin/activate
fi

python -m unittest discover -s src/