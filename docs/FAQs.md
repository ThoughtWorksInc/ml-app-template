# FAQs

### IDE configuration
To get the optimal coding workflow, we often rely on intellisense and code completion provided by our code editors. Unfortunately, this becomes [hard](https://github.com/Microsoft/vscode-python/issues/79#issuecomment-348193800) when our python virtual environment is contained within the docker container. As a workaround, you can:
- Run `bin/configure_venv_locally.sh`. This will create a duplicate python virtual environment (by the name of `.venv-local`) on your host (i.e. your computer)
- Configure your IDE with the python path of this virtual environment:
  - [VS Code](https://code.visualstudio.com/docs/python/environments#_select-and-activate-an-environment)
  - [PyCharm (community edition)](https://www.jetbrains.com/help/pycharm/creating-virtual-environment.html)
  - PyCharm (professional edition) users: you don't need this workaround. You can follow set up your IDE to use the virtual environment in the Docker container (see [instructions])(https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html)


### Common errors and how to solve them

`docker run` causes the following error:
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