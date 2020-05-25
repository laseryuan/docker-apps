FROM {{ARCH.images.base}}

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Upgrade to unstable version
# RUN echo deb http://deb.debian.org/debian sid main non-free contrib >> /etc/apt/sources.list
RUN apt-get update -qy && apt-get install -qy \
      kodi

{{#ARCH.is_amd}}
RUN apt-get install -qy \
      libgl1-mesa-dri \
      mesa-utils
{{/ARCH.is_amd}}

{{#ARCH.is_arm}}
RUN apt-get install -qy \
      `# libEGL support` \
      libgl1-mesa-dri \
      mesa-utils && \
      apt -y --purge autoremove && \
      rm -rf /var/lib/apt/lists/*
{{/ARCH.is_arm}}

RUN useradd -ms /bin/bash kodi

WORKDIR /home/kodi

USER kodi
RUN mkdir -p /home/kodi/.kodi/userdata

COPY --chown=kodi ./docker-entrypoint.sh /
COPY --chown=kodi ./README.md /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
