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
      golang \
      curl gpg pkg-config libssl-dev pinentry-tty

RUN git clone --depth=1 https://github.com/akamai/akr.git
# RUN git clone --depth=1 --branch {{PKG_VERSION}} https://github.com/akamai/akr.git

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN cd akr && \
    $HOME/.cargo/bin/cargo build

# Test
RUN akr/target/debug/akr --version
