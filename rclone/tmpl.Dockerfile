ARG PACKAGE_ARCH=amd64
ARG OS_VERSION=bookworm

FROM debian:${OS_VERSION}-slim

ARG PACKAGE_ARCH
ARG OS_VERSION

RUN \
    apt-get update && \
    apt-get install -y curl unzip fuse3 ffmpeg

RUN \
    curl -L https://downloads.rclone.org/rclone-current-linux-${PACKAGE_ARCH}.zip -o /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp/ && \
    cd /tmp/rclone-* && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

RUN \
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/bin/yt-dlp && \
    chmod a+rx /usr/bin/yt-dlp  # Make executable

# Install ffmpeg
RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
    ca-certificates \
    gnupg \
    curl \
    apt-transport-https \
 && curl -fsSL https://repo.jellyfin.org/jellyfin_team.gpg.key \
  | gpg --dearmor -o /etc/apt/trusted.gpg.d/debian-jellyfin.gpg \
 && echo "deb [arch=${PACKAGE_ARCH}] https://repo.jellyfin.org/master/debian ${OS_VERSION} main" > /etc/apt/sources.list.d/jellyfin.list \
 && apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
    jellyfin-ffmpeg7 \
 && apt-get remove gnupg apt-transport-https --yes \
 && apt-get clean autoclean --yes \
 && apt-get autoremove --yes \
 && rm -rf /var/cache/apt/archives* /var/lib/apt/lists/*

# make the FFmpeg binary easy to find
RUN ln -s /usr/lib/jellyfin-ffmpeg/ffmpeg /usr/local/bin/ffmpeg

# NVIDIA integration is runtime-driven (toolkit + --gpus)
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all

