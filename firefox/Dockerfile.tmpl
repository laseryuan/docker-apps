FROM {{ARCH.images.base}}
# Credit: "Jessie Frazelle <jess@linux.com>"

{{#ARCH.is_amd}}
RUN apt-get update && apt-get install -y \
	--no-install-recommends \
  curl
RUN curl -L https://github.com/mi-g/vdhcoapp/releases/download/v1.6.3/net.downloadhelper.coapp-1.6.3-1_amd64.deb -o /tmp/app.deb && \
  dpkg -i /tmp/app.deb && \
  rm /tmp/app.deb
{{/ARCH.is_amd}}

{{#ARCH.is_arm}}
  RUN apt-get update && apt-get install -y \
  dirmngr \
  gnupg \
  apulse \
  ca-certificates \
  curl \
  ffmpeg \
  firefox-esr \
  hicolor-icon-theme \
  libasound2 \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  libpulse0 \
  fonts-noto \
  fonts-noto-cjk \
  fonts-noto-color-emoji \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

ENV LANG en-US

COPY local.conf /etc/fonts/local.conf

# Disable multi-process tabs in Firefox.
RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox-esr/syspref.js

COPY entrypoint.sh /usr/bin/startfirefox

ENTRYPOINT [ "startfirefox" ]
{{/ARCH.is_arm}}
