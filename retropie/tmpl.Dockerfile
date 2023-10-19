FROM {{ARCH.images.build_base}}

ENV LANG C.UTF-8
ENV LD_LIBRARY_PATH=/usr/local/lib

RUN apt-get update && apt-get install -y \
      ca-certificates git lsb-release sudo \
      curl `# for install.sh` \
      libgl1-mesa-dri \
      udev \
      vim \
      mesa-utils

RUN useradd -d /home/pi -G sudo -m pi

RUN echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi


USER pi
RUN curl -L https://github.com/RetroPie/RetroPie-Setup/archive/{{IMAGE_VERSION}}.tar.gz -o /tmp/retropie.tar.gz && \
    tar xvf /tmp/retropie.tar.gz -C /tmp/ && \
    mv /tmp/RetroPie-Setup-{{IMAGE_VERSION}} /home/pi/RetroPie-Setup

WORKDIR /home/pi/RetroPie-Setup
RUN sudo chmod +x retropie_setup.sh

RUN sudo __platform={{ARCH.rpi_platform}} ./retropie_packages.sh setup basic_install

# https://raw.githubusercontent.com/meleu/RetroPie-joystick-selection/master/install.sh
COPY --chown=pi install.sh /tmp/install.sh

RUN __platform={{ARCH.rpi_platform}} bash /tmp/install.sh

COPY --chown=pi ./docker-entrypoint.sh /
COPY --chown=pi ./README.md /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
