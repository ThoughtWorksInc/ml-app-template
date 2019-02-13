FROM ubuntu:18.10

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev git \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN git config --global user.name '<your username>' \
  && git config --global user.email '<your email>' \
  && git config --global credential.helper cache

WORKDIR /app/continuous-intelligence
COPY requirements.txt /app/continuous-intelligence/
RUN cd /app/continuous-intelligence && pip3 install -r requirements.txt

COPY . /app/continuous-intelligence

EXPOSE 8080

CMD ["/app/continuous-intelligence/bin/start_server.sh"]
