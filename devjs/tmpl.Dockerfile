FROM {{ARCH.images.base}}

# https://github.com/jessfraz/dockerfiles/blob/master/chrome/stable/Dockerfile
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    hicolor-icon-theme \
    libcanberra-gtk* \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpulse0 \
    libv4l-0 \
    fonts-symbola \
    --no-install-recommends \
    ``

{{#ARCH.is_amd}}
RUN \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/*

# https://github.com/puppeteer/puppeteer/blob/main/docker/Dockerfile
RUN apt-get update \
    && apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros fonts-kacst fonts-freefont-ttf libxss1 dbus dbus-x11 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# install chrome version that work with crconsole
ENV \
CHROME_VERSION="104.0.5112.79-1"

RUN \
  wget --no-verbose -O /tmp/chrome.deb https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb \
  && apt install -y --allow-downgrades /tmp/chrome.deb \
  && rm /tmp/chrome.deb
{{/ARCH.is_amd}}

ENV HOME=/home/node

USER node

# Install node modules in parent directory
WORKDIR /home/node

# Install global package
RUN \
npm install laseryuan/locus laseryuan/crconsole live-server pryjs binding-pry-js better-node-inspect

RUN \
npm install puppeteer jest-puppeteer jest jest-dev-server

ENV PATH=/home/node/node_modules/.bin:$PATH

COPY app/templates /templates
COPY app/load.sh /etc/profile.d/
COPY test /home/node/test
COPY README.md /

# testing
RUN \
    cd /home/node/test && bash test.sh

CMD ["cat", "/README.md"]
