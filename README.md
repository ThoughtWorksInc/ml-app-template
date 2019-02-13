# Continuous Intelligence Workshop

A demo on how to apply continuous delivery principles to train, test and deploy ML models.

### Workshop pre-requisites

Before the workshop, please ensure you have done the following:
- Install a code editor of your choice. If you aren’t familiar with a code editor, [VS Code](https://code.visualstudio.com/) or [PyCharm (community edition)](https://www.jetbrains.com/pycharm/download/) are good options.
- Install Docker ([Mac](https://docs.docker.com/docker-for-mac/install/), [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/), [Windows](https://docs.docker.com/docker-for-windows/install/)) (on Windows, make sure to switch to linux containers)
- Install a REST client (e.g. [Insomnia](https://insomnia.rest/))
- Create accounts:
  - [Heroku](https://heroku.com) (first 5 apps will be free) 
  - [Google Cloud Platform](https://cloud.google.com) (free $300 credits when you first sign up)
  - [CircleCI](https://circleci.com) (free)

### Setup

1. **Fork** repository: https://github.com/davified/ci-workshop-app
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
3. Start Docker on your desktop
4. Edit the Dockerfile and replace `<your username>` and `<your email>` with your github username and email
4. Build docker image: 
  - Mac / Linux users: `docker build . -t ai-sg-workshop`
  - Windows users: `docker build . -f Dockerfile.windows -t ai-sg-workshop`
5. Now you're ready to run some commands!
  - Run tests: `docker run -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bin/test.sh` - works fine
  -- executed - `docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop python train.py`
  - Start application: `docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bin/start_server.sh` - failed first time without running train.py command
  - Stop the above daemon else it will give an error of "port already allocated"

  For starting interactive sheel we have two options:
  Option 1
  - Start interactive shell in container: `docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash`
  - Note: Windows users have to add: `--platform linux` after `docker run` (e.g. `docker run --platform linux -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash`)
  Option 2
  - Start a bash shell in a running container when it’s running: `docker exec -it <container-id> /bin/bash` (you can find the container id by running `docker ps`)

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
- split up dev requirements
- install gcloud/heroku in Dockerfile
- create multistage build for Dockerfile: https://docs.docker.com/develop/develop-images/multistage-build/