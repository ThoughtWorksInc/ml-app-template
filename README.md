# Continuous Intelligence Workshop

A demo on how to apply continuous delivery principles to train, test and deploy ML models.

### Workshop pre-requisites

Before the workshop, please ensure you have done the following:
- Install a code editor of your choice. If you aren’t familiar with a code editor, [VS Code](https://code.visualstudio.com/) or [PyCharm (community edition)](https://www.jetbrains.com/pycharm/download/) are good options.
- Install and start Docker
  - [Mac users](https://docs.docker.com/docker-for-mac/install/)
  - [Linux users](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
  - [Windows](https://docs.docker.com/docker-for-windows/install/)
  - **Important things to note**:
    - You will be prompted to create a DockerHub account. Follow the instructions in order to download Docker
    - Follow the installation prompts (go with the default options) **until you have successfully started Docker**
    - [Windows users] When prompted to enable Hyper-V and Containers features, click 'Ok' and let computer restart again.
    - You may have to restart your computer 2-3 times.
- Install a REST client (e.g. [Insomnia](https://insomnia.rest/))
- Create accounts:
  - [Heroku](https://heroku.com) (free) 
  - [CircleCI](https://circleci.com) (free)
- [Windows Users only] Install [git bash](https://gitforwindows.org/). We will be using `git bash` as the terminal for the workshop.

### Setup

Note:
- If you encounter any errors, please refer to [FAQs](./docs/FAQs.md) for a list of common errors and how to fix them.
- If the issue is still not fixed, please [file an issue](https://docs.google.com/forms/d/1pYlJ_m5JvUntZKT0UG5HaY4I_r1ahrhv9ZMps_zNIno/edit) here and we'll look into it.
- [Windows users] If you're new to Docker, please use the Git Bash terminal to run the commands below

Setup instructions

1. Fork repository: https://github.com/davified/ci-workshop-app
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
3. Start Docker on your desktop (Note: Wait for Docker to complete startup before running the subsequent commands. You'll know when startup is completed when the docker icon in your taskbar stops animating)
4. Build docker image

```shell
# [Mac/Linux users]
docker build . -t ci-workshop-app --build-arg user=$(whoami)

# [Windows users]
MSYS_NO_PATHCONV=1 docker build . -t ci-workshop-app --build-arg user=$(whoami)
```

5. Start docker container

```shell
# [Mac/Linux users]
docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash

# [Windows users]
winpty docker run -it -v C:\\Users\\path\\to\\your\\ci-workshop-app:/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash
# Note: to find the path, you can run `pwd` in git bash, and manually replace forward slashes (/) with double backslashes (\\)

```

```diff
! Pre-workshop setup stops here
```

```shell
### Other useful docker commands ###
# See list of running containers
docker ps

# Start a bash shell in a running container when it’s running
docker exec -it <container-id> bash
```

Now you're ready to roll!


### Common commands (run these in the container)

```shell
# Add some color to your terminal
source bin/color_my_terminal.sh

# Run unit tests
python -m unittest discover -s src/

# Train model
python src/train.py

# Start flask app
python src/app.py

# Make requests to your app
# 1. In your browser, visit http://localhost:8080
# 2. In another terminal in the container, run:
bin/predict.sh http://localhost:8080

# You can also use this script to test your deployed application later:
bin/predict.sh http://my-app.herokuapp.com
```

### FAQs

Please refer to [FAQs](./docs/FAQs.md) for:
- a list of common errors that you may encounter, and how you can fix them.
- IDE configuration instructions

### Configuring CD pipeline

Instructions for setting up your CD pipeline are in [docs/CD.md](./docs/CD.md).

Once the CD pipeline is set up, you only need to `git add`, `git commit` and `git push` your code changes, and the CD pipeline will do everything (train, test, deploy) for you.

#### Bonus: Deploying using Kubernetes

Instructions [here](./docs/deploy_to_kubernetes.md)

