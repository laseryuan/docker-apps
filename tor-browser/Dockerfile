FROM jess/tor-browser

USER root

RUN apt update && apt install -y \
      `# audio support` \
      apulse \
      libpulse0 \
      `# fix libcanberra-gtk-module missing issue` \
      libcanberra-gtk-module \
      libcanberra-gtk3-module \
      && rm -rf /var/lib/apt/lists/*

USER user
