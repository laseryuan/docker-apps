ARG debian

FROM $debian

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
      chromium-browser \
      libgl1-mesa-dri \
      mesa-utils \
      && rm -rf /var/lib/apt/lists/*

# Create chromium user
RUN useradd -ms /bin/bash chromium
RUN usermod -aG audio,video chromium

USER chromium

COPY --chown=chromium ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
