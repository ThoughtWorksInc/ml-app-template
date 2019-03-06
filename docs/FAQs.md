# FAQs

### IDE configuration
To get the optimal coding workflow, we often rely on intellisense and code completion provided by our code editors. Unfortunately, this becomes [hard](https://github.com/Microsoft/vscode-python/issues/79#issuecomment-348193800) when our python virtual environment is contained within the docker container. As a workaround, you can:
- Run `bin/configure_venv_locally.sh`. This will create a duplicate python virtual environment (by the name of `.venv-local`) on your host (i.e. your computer)
- Configure your IDE with the python path of this virtual environment:
  - [VS Code](https://code.visualstudio.com/docs/python/environments#_select-and-activate-an-environment)
  - [PyCharm (community edition)](https://www.jetbrains.com/help/pycharm/creating-virtual-environment.html)
  - PyCharm (professional edition) users: you don't need this workaround. You can follow set up your IDE to use the virtual environment in the Docker container (see [instructions])(https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html)
- configure autosave


### Common errors and how to fix them

1. `docker run` causes the following error:
```shell
docker: Error response from daemon: driver failed programming external connectivity on endpoint elated_brown (a26aea6b1fcd5f286dd7164b42
47de2f958f8280140b51ec39eed13e3801037b): Bind for 0.0.0.0:8080 failed: port is already allocated.

# Reason: some container is already running and taken port 8080
# Solution: 
# 1. get id of running container
docker ps

# 2 stop container
docker stop <container-id> 
# e.g. docker stop 9d57a1f8f49a

# Now you can run `docker run` again
```

### [Windows users] Common errors and how to fix them

1. If you encounter the following error, when running `docker run ... -p 8080:8080 ...`:
```shell
docker: Error response from daemon: driver failed programming external connectivity on endpoint zealous_rubin (f70ddf46807daed2b1a24e3f897af1dd587b97b30ef676c8fcdba40598756
c49): Error starting userland proxy: mkdir /port/tcp:0.0.0.0:8080:tcp:172.17.0.2:8080: input/output error.

# Solution: 
# 1. Right click docker icon --> Settings --> Daemon --> Ensure 'Experimental Features' is unchecked
# 2. Restart docker
```

2. You mounted a volume (e.g. `docker run -v /$(pwd):/home/`) but you don't see the mounted directory:
```shell
# solution: replace /$(pwd) with the full path to the directory that you wish to mount:
winpty docker run -it -v C:\\Users\\path\\to\\your\\ci-workshop-app:/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash

# Note: to find the full path, you can run `pwd` in the directory that you wish to mount, and manually replace forward slashes (/) with double backslashes (\\)
```
This is an open issue in Docker for Windows that has to do with how Git Bash converts filepaths: https://github.com/docker/toolbox/issues/673

3. You edited a shell script and tried to run it but got some error about invalid characters (^M)
```shell
# on git bash, convert line endings to unix endings
dos2unix bin/my_file.sh

# now you can execute your script
bin/my_file.sh
```
