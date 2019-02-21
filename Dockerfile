FROM ubuntu:latest as Base

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3-pip python3-venv curl \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

WORKDIR /home/ci-workshop-app
COPY requirements.txt /home/ci-workshop-app/
COPY bin/install_dependencies.sh /home/ci-workshop-app/
RUN /home/ci-workshop-app/install_dependencies.sh

COPY . /home/ci-workshop-app

FROM Base as Dev

RUN apt-get -y install git python3-dev
ARG user
RUN useradd ${user} -g root
USER ${user}
COPY dev-requirements.txt /dev-requirements.txt
RUN cd /home/ci-workshop-app && pip install -r /dev-requirements.txt

RUN git config --global user.name '<your username>' \
  && git config --global user.email '<your email>' \
  && git config --global credential.helper cache

EXPOSE 8080
CMD ["/home/ci-workshop-app/bin/start_server.sh"]
