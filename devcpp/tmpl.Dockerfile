FROM {{ARCH.images.base}}

RUN apt-get update && apt-get install -y build-essential git

ADD https://root.cern.ch/download/cling/cling_2020-11-05_ROOT-ubuntu2004.tar.bz2 /tmp/

WORKDIR /tmp

RUN \
    tar xjf cling_2020-11-05_ROOT-ubuntu2004.tar.bz2 && \
    mv cling_2020-11-05_ROOT-ubuntu2004/ /opt/cling && \
    ln -s /opt/cling/bin/cling /usr/local/bin/ && \
    ln -s /opt/cling/bin/clang++ /usr/local/bin/

# Add libclang, python patch version
RUN \
    git clone http://root.cern.ch/git/clang.git
RUN \
    cd /tmp/clang && \
    git checkout 7a13d39940cfd2

# Build inspector
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y \
    cmake libjsoncpp-dev pkg-config python3-setuptools python3-pip
RUN \
    pip install -U pip && \
    pip install prompt-toolkit pygments

RUN \
    git clone --depth=1 https://github.com/laseryuan/inspector.git && \
    cd inspector && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_PREFIX_PATH="../inst" .. && \
    cmake --build . && \
    ln -s /tmp/inspector/build/inspector /usr/local/bin/

ENV PYTHONPATH=/tmp/clang/bindings/python:/tmp/inspector/build/python/build/lib
ENV LD_LIBRARY_PATH=/opt/cling/lib

# Install reple
RUN pip install reple

# Test
RUN cling --version && inspector -h && reple -h

COPY templates /templates

COPY load.sh /etc/profile.d/
COPY README.md /

CMD ["cat", "/README.md"]
