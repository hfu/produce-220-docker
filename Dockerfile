#

# docker build -no-cache -t produce-220:latest .
# docker run -it --rm -v //d:/export produce-220:latest bash

FROM ubuntu:16.04
RUN apt-get update && apt-get -y upgrade \
  && apt-get -y install apt-transport-https ca-certificates \
  && apt-get -y install build-essential libsqlite3-dev zlib1g-dev \
  && apt-get -y install curl nodejs npm git
RUN npm install n -g && n lts && apt purge -y nodejs npm
RUN mkdir -p /tmp/workdir
WORKDIR /tmp/workdir
RUN git clone https://github.com/mapbox/tippecanoe
WORKDIR /tmp/workdir/tippecanoe
RUN make -j2 && make install
WORKDIR /tmp/workdir
RUN git clone https://github.com/hfu/produce-220
WORKDIR /tmp/workdir/produce-220
RUN npm install
COPY ./default.hjson /tmp/workdir/produce-220/config 
WORKDIR /tmp/workdir/produce-220

