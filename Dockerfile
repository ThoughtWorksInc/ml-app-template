FROM python:3.6.8-slim-stretch as Base

RUN set -x \
    && apt-get -y update \
    && apt-get -y install \
        build-essential \
        libfreetype6-dev \
        libc-dev \
        gfortran

RUN mkdir /install
WORKDIR /install
COPY requirements.txt /requirements.txt
RUN pip install --install-option="--prefix=/install" -r /requirements.txt

FROM Base as Prod

COPY --from=Base /install /usr/local
RUN cd /home/ci-workshop-app
COPY . /home/ci-workshop-app

FROM Prod as Dev
RUN apt-get update && apt-get -y install git
RUN git config --global credential.helper cache
COPY dev-requirements.txt /dev-requirements.txt
RUN cd /home/ci-workshop-app && pip install -r /dev-requirements.txt

FROM Dev as Test
COPY --from=Base /install /usr/local

EXPOSE 8080
CMD ["/home/ci-workshop-app/bin/start_server.sh"]