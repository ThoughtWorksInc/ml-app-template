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
- [Windows Users only] Install [git bash](https://gitforwindows.org/)

### Setup

1. **Fork** repository: https://github.com/davified/ci-workshop-app
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
3. For mac users: run `bin/setup.sh`
3. Start Docker on your desktop
4. Edit the Dockerfile and replace `<your username>` and `<your email>` with your github username and email
4. Build docker image: 
  - Mac / Linux users: `docker build . -t ai-sg-workshop --build-arg user=$(whoami)`
  - Windows users: `docker build . -f Dockerfile.windows -t ai-sg-workshop --build-arg user=$(whoami)`

### Common commands

Now you're ready to run some commands!

```shell
# Start interactive shell in container:
# Mac/Linux users:
docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash
# Windows users (add: `--platform linux` options):
docker run --platform linux -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ai-sg-workshop bash

# Run unit tests
python -m unittest discover -s src/

# Train model
python src/train.py

# Start flask app
python src/app.py

# Make requests to your app
# 1. In your browser, visit http://localhost:8080
# 2. In another terminal in the container, run:
bin/predict.sh

```

6. Some other docker commands that you may find useful
- See list of running containers: `docker ps`
- Start a bash shell in a running container when it’s running: `docker exec -it <container-id> /bin/bash` (you can find the container id by running `docker ps`)

### Errors

Please refer to [FAQs](./docs/FAQs.md) for a list of common errors that you may encounter, and how you can fix them.

### Configuring CD pipeline

Instructions for setting up your CD pipeline are in [docs/CD.md](./docs/CD.md).

Once the CD pipeline is set up, you only need to `git add`, `git commit` and `git push` your code changes, and the CD pipeline will do everything (train, test, deploy) for you.



#### Bonus: Deploying using Kubernetes

Instructions [here](./docs/deploy_to_kubernetes.md)