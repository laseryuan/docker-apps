
FROM balenalib/raspberry-pi-debian:stretch-20191011

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive


RUN apt update -qy && apt install -qy \
      kodi \
      `# libEGL support` \
      libgl1-mesa-dri \
      mesa-utils && \
      apt -y --purge autoremove && \
      rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash kodi

WORKDIR /home/kodi

USER kodi
RUN mkdir -p /home/kodi/.kodi/userdata

COPY --chown=kodi ./docker-entrypoint.sh /
COPY --chown=kodi ./README.md /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
