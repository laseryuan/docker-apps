ARG debian
FROM $debian

ARG arch

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
      ca-certificates git lsb-release sudo \
      libgl1-mesa-dri \
      mesa-utils

RUN useradd -d /home/retropie -G sudo -m pi

RUN echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi

WORKDIR /home/retropie
RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
RUN cd RetroPie-Setup \
    && sudo chmod +x retropie_setup.sh \
    && ./retropie_packages.sh setup basic_install
RUN sudo rm -rf /var/lib/apt/lists/*

# Fix permission issue
RUN chmod +x /root

RUN chown -R pi:pi /home/retropie

RUN usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users pi
# RUN usermod -aG input pi

USER pi
ENTRYPOINT "/usr/bin/emulationstation"
CMD "#auto"
