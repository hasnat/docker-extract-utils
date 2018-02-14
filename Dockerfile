FROM debian:jessie

RUN apt-get update \
    && apt-get -y install ca-certificates unzip pv build-essential xz-utils wget

# From https://github.com/atdt/advcpmv
RUN cd /root && wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.25.tar.xz \
    && tar xvJf coreutils-8.25.tar.xz \
    && cd coreutils-8.25/ \
    && wget https://raw.githubusercontent.com/atdt/advcpmv/master/advcpmv-0.7-8.25.patch \
    && patch -p1 -i advcpmv-0.7-8.25.patch \
    && FORCE_UNSAFE_CONFIGURE=1 ./configure \
    && make \
    && mv ./src/cp /usr/local/bin/cpg \
    && mv ./src/mv /usr/local/bin/mvg

RUN apt-get purge -y --auto-remove ca-certificates wget build-essential \
    && rm -rf /var/lib/apt/lists/*
