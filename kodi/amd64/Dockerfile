# https://hub.docker.com/_/debian
FROM debian:stretch-20191014-slim
# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04


ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qy && apt install -qy \
      kodi
RUN apt install -qy \
      libgl1-mesa-dri \
      mesa-utils
      # `# libEGL support` \
      # mesa-utils && \
      # apt -y --purge autoremove && \
      # rm -rf /var/lib/apt/lists/*


RUN useradd -ms /bin/bash kodi

WORKDIR /home/kodi

USER kodi
RUN mkdir -p /home/kodi/.kodi/userdata

COPY --chown=kodi ./docker-entrypoint.sh /
COPY --chown=kodi ./README.md /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
