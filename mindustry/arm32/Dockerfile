
FROM balenalib/raspberry-pi-debian:stretch-20191011

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Install graphic driver
# RUN apt-get update -qy && apt-get install -qy \
RUN apt-get update -qy && apt-get install -qy --no-install-recommends \
      `# libEGL support` \
      libgl1-mesa-dri \
      mesa-utils

# Install Mindustry
# https://anuke.itch.io/mindustry?download
RUN apt-get install unzip
RUN apt-get install -y xdg-utils
RUN apt-get install -y pulseaudio
ADD ./mindustry-linux-64-bit.zip /tmp/mindustry.zip
RUN cd /tmp && unzip mindustry.zip
# Finish install Mindustry

RUN useradd -ms /bin/bash mindustry

WORKDIR /home/mindustry

USER mindustry

COPY --chown=mindustry ./docker-entrypoint.sh /
COPY --chown=mindustry ./README.md /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
