# https://github.com/SashaNullptr/Fops-Containers/blob/master/Steam/Dockerfile
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -yq upgrade
RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libc6-dev \
        libglu1 \
        libglu1:i386 \
        libsm6 \
        libxv1 \
        libxv1:i386 \
        x11-xkb-utils \
        xauth \
        xfonts-base \
        xkb-data

# RUN apt-get install -y wget gdebi-core libgl1-mesa-dri:i386 libgl1-mesa-glx:i386
RUN apt-get install -y wget gdebi-core
RUN wget http://media.steampowered.com/client/installer/steam.deb
RUN gdebi -n ./steam.deb

RUN useradd -ms /bin/bash steam
# RUN adduser --disabled-password --no-create-home --gecos 'Steam Client' --home /opt/steam steam
# RUN mkdir -p /opt/steam /var/lib/steam /home/steam/.steam/steam/steamapps/common
# RUN chown -R steam:steam /opt/steam /var/lib/steam /home/steam/.steam/steam/steamapps/common
RUN mkdir -p /opt/steam /var/lib/steam
RUN chown -R steam:steam /opt/steam /var/lib/steam

# Preseed dpkg to skip license agreement
RUN echo steam steam/license note '' | debconf-set-selections
RUN echo steam steam/question select "I AGREE" | debconf-set-selections

# Install steam command line tools
RUN apt-get install -y steamcmd
RUN apt-get install -y pciutils
RUN apt-get install -y mesa-utils
RUN ln -s /usr/games/steamcmd /usr/local/bin/steamcmd

# RUN apt-get install -y lib32-nvidia-utils
USER steam
WORKDIR /var/lib/steam

# Bootstraps the Steam client
# RUN steamcmd +login anonymous validate +quit

WORKDIR /home/steam/
# Updates on launch
# ONBUILD RUN steamcmd +login anonymous validate +quit
