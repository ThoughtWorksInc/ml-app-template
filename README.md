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
3. For mac users: run `bin/setup.sh`
3. Start Docker on your desktop
4. Edit the Dockerfile and replace `<your username>` and `<your email>` with your github username and email
4. Build docker image: 
  - Mac / Linux users: `docker build . -t ai-sg-workshop`
  - Windows users: `docker build . -f Dockerfile.windows -t ai-sg-workshop`
5. Now you're ready to run some commands!
  - Start interactive shell in container: `docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash`
  - Run any of the following commands in the docker container:
    - Run tests: `python -m unittest discover -s src/`
    - Train model: `python src/train.py`
    - Start application: `bin/start_server.sh`
  
Note: Windows users have to add: `--platform linux` after `docker run` (e.g. `docker run --platform linux -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash`)
  
6. Some other docker commands that you may find useful
- Start a bash shell in a running container when it’s running: `docker exec -it <container-id> /bin/bash` (you can find the container id by running `docker ps`)

7. We'll be doing most of our coding in the interactive shell. Anything that you used to do in your bash shell, you can also do in the interactive shell of the container. For example:
```shell
# hello world
$ echo "hello world!"

# train model: 
$ python src/train.py

# start flask app
$ python src/app.py
```

To deploy your changes, just `git commit` and `git push`! The CI pipeline (specified in `.circleci/config.yml`) will do everything (train, test, deploy) for you.

RUN git config --global user.name '<your username>' \
  && git config --global user.email '<your email>' \
  && git config --global credential.helper cache


### One-time steps for deployment
#### CircleCI
- Create circleci project. Visit https://circleci.com/dashboard, login and click on 'Add Projects' on the left panel

#### Heroku

- Login to heroku by running: `heroku login`
- Create a heroku project for app (staging): `heroku create ci-workshop-app-<YOUR_NAME>-staging`
- Create a heroku project for app (prod): `heroku create ci-workshop-app-<YOUR_NAME>-prod`
- In `.circleci/config.yml`, replace `ci-workshop-app-bob-staging` and `ci-workshop-app-bob-prod` with the names of your staging and prod apps
- Generate a heroku auth token and copy the 'Token' value : `heroku authorizations:create`
- On CircleCI webpage, go to your project settings (click on the gear icon on your project) and click on 'Environment Variables' on the left panel. Add the following variable:
  - Name: HEROKU_AUTH_TOKEN
  - Value: (paste value created from previous step)

#### GCP App Engine
Note: Deploying to GCP App Engine takes much longer because (i) `gcloud app deploy` just takes that long (5+ minutes), (ii) we need to build a docker image of our application and that takes time (5+ minutes). If you don't want to run the following example, you can still checkout the [CircleCI config](https://gist.github.com/davified/c90cabb7e15fdb2ce5a1f6d34f37cef2) and [sample build log](https://circleci.com/gh/davified/ci-workshop-app/42)

Steps for deploying to GCP App Engine:
- Get secret key from GCP console (follow steps 1-3 of [instructions](https://cloud.google.com/sdk/docs/authorizing#authorizing_with_a_service_account))
- Define environment variable in CircleCI
  - GCLOUD_SERVICE_KEY: (copy and paste contents of secret key)
- If deploying to app engine for the first time, enable [App Engine Admin API](https://console.developers.google.com/apis/api/appengine.googleapis.com/overview?project=ai-sg-workshop) on GCP
