FROM {{ARCH.images.base}}

{{#ARCH.is_amd}}
VOLUME /tmp/.X11-unix

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Can lock screen
RUN \
  apt-get update && apt-get -y install \
      xfce4-screensaver && \
  echo idletimeout=600 >> /etc/tigervnc/vncserver-config-defaults && \
  rm -rf /var/lib/apt/lists/*

RUN \
  mkdir /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

COPY ./locale /tmp/locale
RUN cd /tmp/locale/ && ./install.sh

# fix: passwd/group file permission were reverted by ibus installation
RUN \
  chmod 666 /etc/passwd /etc/group

USER "${HEADLESS_USER_ID}"
{{/ARCH.is_amd}}
