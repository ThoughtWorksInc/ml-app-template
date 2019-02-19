# FAQs

Common errors and how to solve them

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