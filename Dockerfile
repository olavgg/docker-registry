# VERSION 0.1
# AUTHOR:         Olav Grønås Gjerde <olav@backupbay.com>
# DESCRIPTION:    Image with docker-registry project and dependecies
# TO_BUILD:       docker build -rm -t registry .
# TO_RUN:         docker run --rm -p 5000:5000 registry

MAINTAINER Olav Grønås Gjerde <olav@backupbay.com>

FROM olavgg/docker-debian-jessie

# Set the version you want of docker registry
ENV REGISTRY_VERSION master

# Update
RUN apt-get update
RUN apt-get -y upgrade

# Install software
RUN apt-get -y install python-pip wget unzip python-dev\
  liblzma-dev libevent-dev

# Install the master branch of docker-registry
RUN wget \
  https://github.com/dotcloud/docker-registry/archive/$REGISTRY_VERSION.zip\
  -O docker-registry.zip
RUN unzip docker-registry.zip
RUN mv docker-registry-$REGISTRY_VERSION docker-registry
RUN rm docker-registry.zip

ADD config.yml /etc/docker/

RUN cd docker-registry; cp config/boto.cfg /etc/boto.cfg

# Install core
run pip install docker-registry/depends/docker-registry-core

# Install registry
run pip install file:///docker-registry#egg=docker-registry[bugsnag]

ENV DOCKER_REGISTRY_CONFIG /etc/docker/config.yml
ENV SETTINGS_FLAVOR local

VOLUME /docker-registry-storage
expose 5000

CMD gunicorn -k gevent -b 0.0.0.0:5000 --max-requests 100 --graceful-timeout 3600\
        -t 3600 -w 8 docker_registry.wsgi:application

