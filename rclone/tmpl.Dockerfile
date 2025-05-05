FROM {{ARCH.images.base}}

{{#ARCH.is_amd}}
ENV repo_version="rclone-current-linux-amd64"
{{/ARCH.is_amd}}

{{#ARCH.is_arm}}
ENV repo_version="rclone-current-linux-arm64"
{{/ARCH.is_arm}}

RUN \
    apt-get update && \
    apt-get install -y curl unzip fuse3 ffmpeg

RUN \
    curl -L https://downloads.rclone.org/${repo_version}.zip -o /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp/ && \
    cd /tmp/rclone-* && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

RUN \
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/bin/yt-dlp && \
    chmod a+rx /usr/bin/yt-dlp  # Make executable
