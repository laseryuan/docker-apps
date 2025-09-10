# ---- stage 1: rclone binary ----
FROM rclone/rclone:latest AS rclone_src

# ---- stage 2: build ffmpeg with nvenc/nvdec ----
FROM ubuntu:24.04 AS ffmpeg_build

ARG DEBIAN_FRONTEND=noninteractive
ARG FFMPEG_VERSION=8.0  # stable, adjust if you want newer

RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential pkg-config yasm nasm \
    cmake ninja-build meson autoconf automake libtool \
    curl ca-certificates \
    # optional: commonly-used runtime libs for filters/subtitles
    libfreetype6-dev libfontconfig1-dev libfribidi-dev libass-dev \
    # codecs (GPL, but NOT nonfree)
    libx264-dev libx265-dev libvpx-dev libopus-dev libvorbis-dev \
    && rm -rf /var/lib/apt/lists/*

# nv-codec-headers (for NVENC/NVDEC)
RUN git clone --depth=1 https://git.videolan.org/git/ffmpeg/nv-codec-headers.git /tmp/nv-codec-headers && \
    make -C /tmp/nv-codec-headers install

# FFmpeg source
RUN git clone --branch release/${FFMPEG_VERSION} --depth=1 https://git.ffmpeg.org/ffmpeg.git /tmp/ffmpeg

WORKDIR /tmp/ffmpeg
# Build GPL (x264/x265) but keep redistributable (no fdk-aac / nonfree)
RUN ./configure \
    --prefix=/opt/ffmpeg \
    --pkg-config-flags="--static" \
    --enable-gpl \
    --enable-libx264 --enable-libx265 --enable-libvpx \
    --enable-libopus --enable-libvorbis \
    --enable-libass --enable-libfreetype --enable-fontconfig \
    --enable-cuvid --enable-nvenc --enable-nvdec \
    --enable-libdrm \
    --enable-shared \
    --disable-debug \
    && make -j"$(nproc)" && make install

# ---- stage 3: final CUDA runtime + rclone + ffmpeg ----
FROM nvidia/cuda:12.9.1-runtime-ubuntu24.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates fuse3 tzdata \
      # runtime libs that FFmpeg links against (match build deps)
      libx264-164 libx265-199 libvpx9 libopus0 libvorbis0a libvorbisenc2 \
      libass9 libfreetype6 libfontconfig1 libfribidi0 libdrm2 \
    && rm -rf /var/lib/apt/lists/*

# rclone
COPY --from=rclone_src /usr/local/bin/rclone /usr/local/bin/rclone
RUN ln -s /usr/local/bin/rclone /usr/bin/rclone

# ffmpeg/ffprobe
COPY --from=ffmpeg_build /opt/ffmpeg /usr/local
ENV PATH="/usr/local/bin:${PATH}"

# NVIDIA runtime hints (include "video" for NVENC/NVDEC)
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility,video

ENV RCLONE_CONFIG=/config/rclone/rclone.conf
