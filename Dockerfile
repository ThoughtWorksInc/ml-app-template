FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev git \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN git config --global user.name '<your username>' \
  && git config --global user.email '<your email>' \
  && git config --global credential.helper cache

WORKDIR /home/ci-workshop-app
COPY requirements.txt /home/ci-workshop-app/
RUN cd /home/ci-workshop-app && pip3 install -r requirements.txt

COPY . /home/ci-workshop-app

EXPOSE 8080

CMD ["/home/ci-workshop-app/bin/start_server.sh"]
