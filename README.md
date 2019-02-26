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
  - [Heroku](https://heroku.com) (first 5 apps will be free) 
  - [CircleCI](https://circleci.com) (free)
- [Windows Users only] Install [git bash](https://gitforwindows.org/). We will be using `git bash` as the terminal for the workshop.

### Setup
**[Windows users] Please use the Git Bash terminal to run the commands below**

1. **Fork** repository: https://github.com/davified/ci-workshop-app
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
<<<<<<< HEAD
3. Start Docker on your desktop (Note: Wait for Docker to complete startup before running the subsequent commands. You'll know when startup is completed when the docker icon in your taskbar stops animating)
=======
3. Start Docker on your desktop
4. Edit the Dockerfile and replace `<your username>` and `<your email>` with your github username and email
5. Build docker image: 
  - Mac / Linux users: `docker build . -t ci-workshop-app --build-arg user=$(whoami)`
  - Windows users: `MSYS_NO_PATHCONV=1 docker build . -t ci-workshop-app --build-arg user=$(whoami)`
>>>>>>> Update windows instructions

4. Docker commands (run this on your terminal)

```shell
# Build docker image
$ docker build . -t ci-workshop-app --build-arg user=$(whoami)

# Start bash shell in container
$ docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash
```

```diff
! Pre-workshop setup stops here
```

```shell
<<<<<<< HEAD
### Other useful docker commands ###
# See list of running containers
docker ps
=======
# Start interactive shell in container:
# Mac/Linux users:
docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash
# Windows users (add: `--platform linux` options):
MSYS_NO_PATHCONV=1 winpty docker run -it -v /$(pwd):/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash
>>>>>>> Update windows instructions

# Start a bash shell in a running container when it’s running
docker exec -it <container-id> bash
```

Now you're ready to roll!


### Common commands (run this in the container)

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

reply to https://stackoverflow.com/questions/52866657/the-source-path-is-not-found-and-not-know-to-docker with https://stackoverflow.com/questions/50608301/docker-mounted-volume-adds-c-to-end-of-windows-path-when-translating-from-linux


if you encounter the following error:
docker: Error response from daemon: driver failed programming external connectivity on endpoint zealous_rubin (f70ddf46807daed2b1a24e3f897af1dd587b97b30ef676c8fcdba40598756
c49): Error starting userland proxy: mkdir /port/tcp:0.0.0.0:8080:tcp:172.17.0.2:8080: input/output error.

solution: 
1. restart docker
2. Right click docker icon --> Settings --> Daemon --> ensure 'Experimental Features' is unchecked


if after running build and/or mount volume, your docker container has no files, 
TODO: find fix

prefix all docker commands with MSYS_NO_PATHCONV=1
e.g. MSYS_NO_PATHCONV=1 docker build . -t ci-workshop-app