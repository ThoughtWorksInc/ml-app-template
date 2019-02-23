FROM ubuntu:latest as Build

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3-pip curl git \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

WORKDIR /home/ci-workshop-app
COPY requirements.txt /home/ci-workshop-app/
RUN pip install -r requirements.txt

COPY . /home/ci-workshop-app

RUN /home/ci-workshop-app/bin/train_model.sh
CMD ["/home/ci-workshop-app/bin/start_server.sh"]

FROM Build as Dev

RUN apt-get -y install python3-dev
COPY requirements-dev.txt /home/ci-workshop-app/requirements-dev.txt
RUN pip install -r /home/ci-workshop-app/requirements-dev.txt

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

ARG user
RUN useradd ${user:-root} -g root || true
USER ${user:-root}

EXPOSE 8080
CMD ["/home/ci-workshop-app/bin/start_server.sh"]
