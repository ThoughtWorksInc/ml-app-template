# Continuous Intelligence Workshop

A demo on how to apply continuous delivery principles to train, test and deploy ML models.

### Setup

Note:
- If you encounter any errors, please refer to [FAQs](./docs/FAQs.md) for a list of common errors and how to fix them.
- [Windows users] If you're new to Docker, please use Git Bash to run the commands below

**Setup instructions**

1. Please ensure you've completed the [pre-requisite setup](./docs/pre-requisites.md)
2. Fork repository: https://github.com/davified/ci-workshop-app
3. Clone repository: `git clone https://github.com/YOUR_USERNAME/ci-workshop-app`
4. Start Docker on your desktop (Note: Wait for Docker to complete startup before running the subsequent commands. You'll know when startup is completed when the docker icon in your taskbar stops animating)
5. Build docker image

```shell
# [Mac/Linux users]
docker build . -t ci-workshop-app --build-arg user=$(whoami)

# [Windows users]
MSYS_NO_PATHCONV=1 docker build . -t ci-workshop-app --build-arg user=$(whoami)
```

6. Start docker container

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
nosetests

# Train model
SHOULD_USE_MLFLOW=false python src/train.py

# Start flask app
python src/app.py

# Make requests to your app
# 1. In your browser, visit http://localhost:8080
# 2. In another terminal in the container, run:
bin/predict.sh http://localhost:8080

# You can also use this script to test your deployed application later:
bin/predict.sh http://my-app.herokuapp.com
```

### IDE configuration

Please refer to [FAQs](./docs/FAQs.md) for instructions on configuring VS Code or PyCharm.

### Set up CD pipeline

Instructions for setting up your CD pipeline are in [docs/CD.md](./docs/CD.md). To keep this example simple, we will deploy to heroku.

Once the CD pipeline is set up, you only need to `git add`, `git commit` and `git push` your code changes, and the CD pipeline will do everything (train, test, deploy) for you.

#### Bonus: Set up CD pipeline

You can also configure your CD pipeline to deploy using kubernetes instead. See instructions [here](./docs/deploy_to_kubernetes.md)

