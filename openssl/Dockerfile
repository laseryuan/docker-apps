ARG OPENSSL_VERSION=1.1.1d
RUN \
    cd /tmp && \
    curl -fsSL -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz && \
    tar -xzf openssl-${OPENSSL_VERSION}.tar.gz && \
    cd openssl-${OPENSSL_VERSION} && \
    ./config && \
    make test && \
    make install && \
    rm /usr/bin/openssl && \
    ln -sf /usr/local/bin/openssl /usr/bin/openssl && \
    ldconfig
