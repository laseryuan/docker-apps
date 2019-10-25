# noVNC + TurboVNC +VirtualGL
# http://novnc.com
# https://turbovnc.org
# https://virtualgl.org

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq upgrade && apt-get -y autoremove

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gcc \
        libc6-dev \
        libglu1 \
        libglu1:i386 \
        libsm6 \
        libxv1 \
        libxv1:i386 \
        make \
        python \
        python-numpy \
        x11-xkb-utils \
        xauth \
        xfonts-base \
        xkb-data

# Install windows manager
RUN apt-get install -y \
        xfce4

ARG TURBOVNC_VERSION=2.2.3
ARG VIRTUALGL_VERSION=2.6.2
ARG LIBJPEG_VERSION=2.0.3
ARG WEBSOCKIFY_VERSION=0.8.0
ARG NOVNC_VERSION=1.1.0

RUN cd /tmp && \
    curl -fsSL -O https://ayera.dl.sourceforge.net/project/turbovnc/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb \
        -O https://ayera.dl.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_VERSION}/libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb \
        -O https://ayera.dl.sourceforge.net/project/virtualgl/${VIRTUALGL_VERSION}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb \
        -O https://ayera.dl.sourceforge.net/project/virtualgl/${VIRTUALGL_VERSION}/virtualgl32_${VIRTUALGL_VERSION}_amd64.deb && \
    dpkg -i *.deb && \
    rm -f /tmp/*.deb && \
    sed -i 's/$host:/unix:/g' /opt/TurboVNC/bin/vncserver

ENV PATH ${PATH}:/opt/VirtualGL/bin:/opt/TurboVNC/bin

RUN curl -fsSL https://github.com/novnc/noVNC/archive/v${NOVNC_VERSION}.tar.gz | tar -xzf - -C /opt && \
    curl -fsSL https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz | tar -xzf - -C /opt && \
    mv /opt/noVNC-${NOVNC_VERSION} /opt/noVNC && \
    mv /opt/websockify-${WEBSOCKIFY_VERSION} /opt/websockify && \
    ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html && \
    cd /opt/websockify && make

COPY self.pem /

# Finish windows manager: somehow this need to be installed after turbovnc in order to be found by turbovnc

# Install Barrier
# https://github.com/debauchee/barrier
RUN apt-get install -y --no-install-recommends \
        git cmake make xorg-dev g++ libcurl4-openssl-dev \
        libavahi-compat-libdnssd-dev libssl-dev libx11-dev \
        libqt4-dev qtbase5-dev

ARG BARRIER_VERSION=2.3.2
RUN cd /tmp && \
    curl -fsSL -O https://github.com/debauchee/barrier/archive/v${BARRIER_VERSION}.tar.gz && \
    tar -xzf v${BARRIER_VERSION}.tar.gz && \
    cd barrier-${BARRIER_VERSION} && \
    ./clean_build.sh && \
    cd build && \
    make install
# Finish install Barrier

RUN mkdir -m 777 /tmp/.X11-unix

RUN useradd -ms /bin/bash app
USER app

COPY ./turbovncserver-security.conf /etc/
COPY ./docker-entrypoint.sh /
COPY ./README.md /

EXPOSE 5901
ENV DISPLAY :1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
