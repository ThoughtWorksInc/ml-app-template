FROM ubuntu:latest as Base

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3-pip curl \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

WORKDIR /home/ci-workshop-app
COPY requirements.txt /home/ci-workshop-app/
RUN pip install -r requirements.txt

COPY . /home/ci-workshop-app

FROM Base as Dev

RUN apt-get -y install git python3-dev
COPY dev-requirements.txt /home/ci-workshop-app/dev-requirements.txt
RUN pip install -r /home/ci-workshop-app/dev-requirements.txt

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

ARG user
RUN useradd ${user} -g root
USER ${user}

EXPOSE 8080
CMD ["/home/ci-workshop-app/bin/start_server.sh"]
