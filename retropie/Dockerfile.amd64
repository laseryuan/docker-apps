FROM debian:stretch-20181226-slim



ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
      ca-certificates git lsb-release sudo \
      curl `# for install.sh` \
      libgl1-mesa-dri \
      udev \
      vim \
      mesa-utils

RUN useradd -d /home/pi -G sudo -m pi

RUN echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi

WORKDIR /home/pi

USER pi
RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
RUN cd RetroPie-Setup \
    && sudo chmod +x retropie_setup.sh \
    && sudo ./retropie_packages.sh setup basic_install


# https://raw.githubusercontent.com/meleu/RetroPie-joystick-selection/master/install.sh
COPY --chown=pi install.sh /tmp/install.sh

RUN bash /tmp/install.sh




COPY --chown=pi ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["run"]
