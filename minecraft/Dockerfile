RUN apt install -yq \
      gdebi-core \
      openjdk-8-jre \
      flite

# RUN curl -o /tmp/Minecraft.deb https://launcher.mojang.com/download/Minecraft.deb
# RUN curl -o /tmp/Minecraft.deb https://launcher.mojang.com/download/Minecraft-beta.deb
# ADD ./Minecraft.deb /tmp/
ADD ./Minecraft-beta.deb /tmp/Minecraft.deb
RUN gdebi --n /tmp/Minecraft.deb

