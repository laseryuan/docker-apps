# https://leimao.github.io/blog/Docker-Wine/
FROM {{ARCH.images.base}}

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update -y && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        ca-certificates \
        language-pack-en \
        language-pack-zh-han* \
        locales \
        locales-all \
        wget

# Install Wine
RUN \
  dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    mkdir -pm755 /etc/apt/keyrings && \
    mv winehq.key /etc/apt/keyrings/winehq-archive.key && \
    wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources && \
    mv winehq-focal.sources /etc/apt/sources.list.d/ && \
    apt-get update -y && \
    apt-get install -y --install-recommends winehq-stable

# GStreamer plugins
RUN \
  apt-get update -y && \
    apt-get install -y --install-recommends \
        gstreamer1.0-libav:i386 \
        gstreamer1.0-plugins-bad:i386 \
        gstreamer1.0-plugins-base:i386 \
        gstreamer1.0-plugins-good:i386 \
        gstreamer1.0-plugins-ugly:i386 \
        gstreamer1.0-pulseaudio:i386

# wine
# Install dependencies for display scaling
RUN \
  apt-get update -y && \
    apt-get install -y --install-recommends \
        build-essential \
        bc \
        git \
        xpra \
        xvfb \
        python3 \
        python3-pip

# Install OpenGL acceleration for display scaling
RUN \
  pip3 install PyOpenGL==3.1.5 PyOpenGL_accelerate==3.1.5

# Install display scaling script
RUN \
  cd /tmp && \
    git clone https://github.com/kaueraal/run_scaled.git && \
    cp /tmp/run_scaled/run_scaled /usr/local/bin/

# wine1
# Install missing fonts for Chinese
# https://blog.no2don.com/2021/04/rpi-dpkg-unrecoverable-fatal-error.html
RUN \
  sed -i '/messagebus/d' /var/lib/dpkg/statoverride
RUN \
  apt-get update -y && \
    apt-get install -y --install-recommends \
        fonts-wqy-microhei


# Install driver for Intel HD graphics
RUN \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri
