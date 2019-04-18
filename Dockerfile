# ================================================================= #
# ------------ First stage in our multistage Dockerfile ----------- #
# ================================================================= #
FROM python:3.6-slim as Base

RUN apt-get update \
  && apt-get install -y curl git

WORKDIR /home/ml-app-template

COPY requirements.txt /home/ml-app-template/requirements.txt
RUN pip install -r requirements.txt

COPY . /home/ml-app-template

# ================================================================= #
# ------------ Second stage in our multistage Dockerfile ---------- #
# ================================================================= #

FROM Base as Build

ARG CI
ENV CI=$CI

RUN /home/ml-app-template/bin/train_model.sh

CMD ["/home/ml-app-template/bin/start_server.sh"]

# ================================================================= #
# ------------ Third stage in our multistage Dockerfile ----------- #
# ================================================================= #
FROM Build as Dev

COPY requirements-dev.txt /home/ml-app-template/requirements-dev.txt
RUN pip install -r /home/ml-app-template/requirements-dev.txt

RUN git config --global credential.helper 'cache --timeout=36000'

EXPOSE 8080

ARG user
RUN useradd ${user:-root} -g root || true
USER ${user:-root}

CMD ["/home/ml-app-template/bin/start_server.sh"]
