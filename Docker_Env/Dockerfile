FROM ubuntu:16.04

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    wget \
    curl \
    git \
    unzip \
    vim \
    net-tools \
    postgresql \
    postgresql-contrib \
    libpq-dev \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libc6-dev \
    supervisor \
    python3-dev \
    libmodbus-dev \
    libiconv-hook-dev \
    mosquitto \
    expect \
    sudo \
    iputils-ping \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://www.openssl.org/source/openssl-1.1.1q.tar.gz \
    && tar -xzf openssl-1.1.1q.tar.gz \
    && cd openssl-1.1.1q \
    && ./config shared zlib \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf openssl-1.1.1q.tar.gz openssl-1.1.1q

RUN wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz \
    && tar -xf Python-3.10.9.tgz \
    && cd Python-3.10.9 \
    && ./configure --enable-optimizations --prefix=/usr/local \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf Python-3.10.9 Python-3.10.9.tgz

RUN wget https://github.com/msgpack/msgpack-c/releases/download/c-6.1.0/msgpack-c-6.1.0.tar.gz \
    && tar -xzf msgpack-c-6.1.0.tar.gz \
    && cd msgpack-c-6.1.0 \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DMSGPACK_BUILD_TESTS=OFF -DMSGPACK_BUILD_EXAMPLES=OFF \
    && make -j$(nproc) \
    && make install \
    && cd ../../ \
    && rm -rf msgpack-c-6.1.0.tar.gz msgpack-c-6.1.0

COPY libgpio.so /lib/
COPY libgpio.so /usr/lib/
RUN ldconfig

