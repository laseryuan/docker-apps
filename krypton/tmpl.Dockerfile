FROM {{ARCH.images.base}}

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qy && apt-get install -qy \
      `# build support` \
      build-essential \
      ca-certificates \
      `# go language` \
      git \
      sudo \
      golang

RUN git clone --depth=1 https://github.com/kryptco/kr.git

RUN cd kr && \
      make install && \
      make start

# Test
RUN kr --version
