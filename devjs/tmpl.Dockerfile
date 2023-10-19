FROM {{ARCH.images.base}}

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chrome that Puppeteer
# installs, work.
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros fonts-kacst fonts-freefont-ttf libxss1 dbus dbus-x11 \
      --no-install-recommends \
    && service dbus start \
    && rm -rf /var/lib/apt/lists/*

# install chrome version that work with crconsole
ENV \
CHROME_VERSION="104.0.5112.79-1"

RUN \
wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb \
  && apt install -y --allow-downgrades /tmp/chrome.deb \
  && rm /tmp/chrome.deb

ENV HOME=/home/node

USER node

# Install node modules in parent directory
WORKDIR /home/node/node_app

# Install the application's dependencies inside the container
RUN \
npm install locus crconsole live-server pryjs binding-pry-js better-node-inspect

ENV PATH=/home/node/node_app/node_modules/.bin:$PATH


CMD ["cat", "/README.md"]
