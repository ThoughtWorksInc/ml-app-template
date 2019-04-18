# `ml-app-template`

A ML project template with sensible defaults:
- Dockerised dev setup
- Unit test setup
- Automated tests for model metrics
- CI pipeline as code

## Getting started

Note: Setup instructions for Windows users can be found [here](./docs/workshop_setup.md)

1. Fork repository: https://github.com/davified/ml-app-template
2. Clone repository: `git clone https://github.com/YOUR_USERNAME/ml-app-template`
3. Install Docker ([Mac](https://docs.docker.com/docker-for-mac/install/), [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/))
4. Start Docker on your desktop
5. Build image and start container:

```shell
# build docker image
docker build . -t ml-app-template --build-arg user=$(whoami)

# start docker container
docker run -it  -v $(pwd):/home/ml-app-template \
                -p 8080:8080 \
                -p 8888:8888 \
                ml-app-template bash
```

## Common commands

Here are some common commands that you can run in your dev workflow. Run these in the container.

```shell
# add some color to your terminal
source bin/color_my_terminal.sh

# run unit tests
nosetests

# run unit tests in watch mode and color output
nosetests --with-watch --rednose --nologcapture

# train model
SHOULD_USE_MLFLOW=false python src/train.py

# start flask app
python src/app.py

# make requests to your app
# 1. In your browser, visit http://localhost:8080
# 2. Open another terminal in the running container (detailed instructions below) and run:
bin/predict.sh http://localhost:8080

# You can also use this script to test your deployed application later:
bin/predict.sh http://my-app.com
```

### Other useful docker commands ###
```shell
# see list of running containers
docker ps

# start a bash shell in a running container when it’s running
docker exec -it <container-id> bash
```

### IDE configuration

Please refer to [FAQs](./FAQs.md) for instructions on how to configure VS Code or PyCharm to give you intellisense and auto-complete suggestions as yo ucode..

## References
- [Workshop instructions](./docs/workshop_setup.md)

TODO:
- replace ml-app-template with `ml-app-template` everywhere



