# Continuous Intelligence Workshop

A simple example to demonstrate the training, testing and deployment of ML models and a simple flask app

### Workshop pre-requisites

Before the workshop, please install the following:
- A code editor of your choice. If you aren’t familiar with a code editor, you can either install [VS Code](https://code.visualstudio.com/) or [PyCharm (community edition)](https://www.jetbrains.com/pycharm/download/)
- Install Docker ([Mac](https://docs.docker.com/docker-for-mac/install/), [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/), [Windows](https://docs.docker.com/docker-for-windows/install/)) (on Windows, make sure to switch to linux containers)
- Install a REST client (e.g. [Insomnia](https://insomnia.rest/))

### Setup

1. **Fork** repository: https://github.com/davified/ci-workshop-app
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
3. Start Docker on your desktop
4. Build docker image: 
  - Mac / Linux users: `docker build . -t ai-sg-workshop`
  - Windows users: `docker build . -f Dockerfile.windows -t ai-sg-workshop`
5. Now you're ready to run somme commands!
  - Run tests: `docker run -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bin/test.sh`
  - Start application: `docker run -it -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bin/start_server.sh`
  - Start interactive shell in container: `docker run -it -v $(pwd):/app/continuous-intelligence -p 8080:8080 ai-sg-workshop bash`
6. We'll be doing most of our coding in the interactive shell. Anything that you used to do in your bash shell, you can also do in the interactive shell of the container. For example:
```shell
# hello world
$ echo "hello world!"

# train model: 
$ python train.py

# start flask app
$ python app.py
```

To deploy your changes, just `git commit` and `git push`! The CI pipeline (specified in `.circleci/config.yml`) will do everything (train, test, deploy) for you.


### Some manual steps:
#### CircleCI
- create circleci project
- add HEROKU_API_KEY (you can obtain this by running `heroku auth:token` in the docker container) to the [CircleCI project](https://circleci.com/gh/davified/simple-cd-demo/) as an environment variable 

#### GCP
- set environment vars
  - GCLOUD_SERVICE_KEY (follow steps 1-3 of: https://cloud.google.com/sdk/docs/authorizing#authorizing_with_a_service_account)

- enable APIs on GCP
  - App Engine Admin API: https://console.developers.google.com/apis/api/appengine.googleapis.com/overview?project=ai-sg-workshop

#### Heroku?

#### Deployment
Some manual steps for deployment (needs to be done only once when you first deploy)
- provision app for the first time: `bin/provision.sh` (this needs to be done only once and can be done from your local machine)
  

### TODOS:
- pip freeze and set dependency versions in requirements.txt
- split up dev requirements
- install gcloud/heroku in Dockerfile
- global replace `/app/continuous-intelligence` as `/home`