#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
#CMD ["bash"]

# Install NodeJS
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs git

EXPOSE 3000

# Repo
RUN echo '201s22s501' >/dev/null
RUN git clone "https://github.com/DinhQuangBinh/nodejs_demo.git"
WORKDIR /root/nodejs_demo
#RUN git pull
RUN sed -i 's/mongodb\:\/\/localhost/mongodb\:\/\/db/' config/database.js
RUN sed -i 's/127.0.0.1/memcached/' server.js
RUN sed -i 's/localhost/activemq/' config/cron.js
RUN sed -i 's/172.30.1.13/mysql_server/' server/controllers/items-controller.js
RUN sed -i 's/172.30.1.13/mysql_server/' config/database.js
RUN npm install -d
#RUN node server.js
