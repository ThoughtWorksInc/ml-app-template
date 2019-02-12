# Simple ML CD demo

A simple model to demonstrate the training, testing and deployment of ML models and a simple flask app

- app: http://simple-cd-demo.herokuapp.com
- CI: https://circleci.com/gh/davified/simple-cd-demo/

### Setup and deployment

Local
- local setup: `bin/setup.sh`
- test: `bin/test.sh`
- train model: `python train.py`
- start flask app: `python app.py`
- Some manual steps for deployment (needs to be done only once when you first deploy)
  - provision app for the first time: `bin/provision.sh` (this needs to be done only once and can be done from your local machine)
  - add HEROKU_API_KEY (you can obtain this by running `heroku auth:token`) to the [CircleCI project](https://circleci.com/gh/davified/simple-cd-demo/) as an environment variable 


To deploy your changes, just `git commit` and `git push`! The CI pipeline (specified in `.circleci/config.yml`) will do everything (train, test, deploy) for you.

### Principles
- do everything once by hand first, then automate on your CI pipeline


### TODOS:
- pip freeze and set dependency versions in requirements.txt

manual steps:
- create circleci project
- set environment vars
  - GCLOUD_SERVICE_KEY (follow steps 1-3 of: https://cloud.google.com/sdk/docs/authorizing#authorizing_with_a_service_account)