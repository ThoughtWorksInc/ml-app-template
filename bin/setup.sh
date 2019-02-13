#!/usr/bin/env bash

set -e

if hash brew 2>/dev/null; then
  echo "Homebrew is already installed!"
else
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sudo chown -R $(whoami) /usr/local/bin
fi

brew tap caskroom/cask
brew tap caskroom/versions

if hash gcloud 2>/dev/null; then
  echo "Google Cloud SDK is already installed!"
else
  echo "Installing Google Cloud SDK..."
  brew cask install google-cloud-sdk
fi

if hash heroku 2>/dev/null; then
  echo "heroku is already installed!"
else
  brew tap heroku/brew && brew install heroku
fi

echo "Setup complete!"