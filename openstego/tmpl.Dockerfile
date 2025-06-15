FROM {{ARCH.images.base}}

ENV LANG=C.UTF-8

# Install unzip
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

ADD https://github.com/syvaidya/openstego/releases/download/openstego-{{PKG_VERSION}}/openstego-{{PKG_VERSION}}.zip /tmp/
RUN unzip /tmp/openstego-{{PKG_VERSION}}.zip
RUN mv openstego-{{PKG_VERSION}} openstego

RUN useradd -ms /bin/bash openstego

USER openstego
WORKDIR /home/openstego
