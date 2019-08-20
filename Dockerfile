# Docker image for building blender for linux

FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y --no-install-recommends \
    gcc \
    g++ \
    libc-dev \
    make \
    diffutils \
    patchutils \
    ca-certificates \
    cmake \
    git \
    libxi-dev \
    libxrandr-dev \
    libxinerama-dev \
    libsqlite3-dev \
    libbz2-dev \
    libssl-dev \
    libxml2-dev \
    libtinyxml-dev \
    libyaml-cpp-dev \
    libsdl1.2-dev \
    libfreetype6-dev \
    libxcursor-dev \
    libtool \
    gettext \
    autoconf \
    automake \
    bison \
    flex \
    yasm \
    wget \
    gawk \
    && rm -rf /var/lib/apt/lists/*

VOLUME /data

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
