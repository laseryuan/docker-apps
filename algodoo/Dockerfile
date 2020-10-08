FROM x11docker/xfce-wine-playonlinux

ENV DEBIAN_FRONTEND=noninteractive

# Add non-free apt sources
RUN sed -i "s#deb http://deb.debian.org/debian buster main#deb http://deb.debian.org/debian buster main non-free#g" /etc/apt/sources.list

RUN apt-get update && apt-get install -yq \
      nvidia-legacy-390xx-driver
