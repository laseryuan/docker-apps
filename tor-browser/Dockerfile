FROM jess/tor-browser

USER root

RUN chmod 777 /tmp
RUN apt update && apt install -y \
      `# audio support` \
      libpulse0 \
      `# fix libcanberra-gtk-module missing issue` \
      libcanberra-gtk-module \
      libcanberra-gtk3-module \
      && rm -rf /var/lib/apt/lists/*

RUN chown -R user:user /usr/local/bin

USER user
