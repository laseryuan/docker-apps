FROM ubuntu

RUN \
  apt-get update -y

RUN \
  apt-get install -y tzdata

RUN \
  apt-get install -y software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:lyx-devel/release && \
  apt-get update -y && \
  apt-get install -y lyx

RUN useradd -ms /bin/bash app
USER app

RUN mkdir /home/app/app
RUN mkdir /home/app/.lyx

WORKDIR /home/app/app

ENTRYPOINT [ "lyx"  ]
