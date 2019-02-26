#!/bin/bash
set -e

which python3
if [ $? -ne 0 ]; then
  if [[ $(uname) == 'Darwin' ]]; then
    # mac users
    which brew
    if [ $? -ne 0 ]; then
      echo "INFO: Installing homebrew"
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    echo "INFO: Installing python3"
    brew install python3
  else
    echo "Please install Python 3 before using this script"
    echo "Exiting..."

    exit 1
  fi
fi

python3 -m venv .venv-local

source .venv-local/bin/activate
pip install --upgrade pip
pip install -r requirements-dev.txt
