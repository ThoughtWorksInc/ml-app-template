#!/usr/bin/env bash

which brew
if [ $? -ne 0 ]; then
  echo "INFO: Installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

which python3
if [ $? -ne 0 ]; then
  echo "INFO: Installing python3"
  brew install python3
fi

# install gcloud
# install docker
# start docker daemon
# docker build

echo "================ 🚀 🚀 🚀 🚀 🚀 🚀 ================ "
echo "Setup completed."
echo "To get started, run the following commands:"
echo "- Start bash shell in container: docker run -it -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bash"
echo "- Run tests:                     docker run -it -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bin/test.sh"
echo "- Start application:             docker run -it -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bin/start_server.sh"
echo "To stop jupyter notebook, hit Ctrl+C"