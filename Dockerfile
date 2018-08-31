# Docker image for building blender for linux

FROM debian:stretch
MAINTAINER arto.kitula@gmail.com

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
	nasm \
	tcl \
    python \
	libffi-dev \
    libopenjp2-7-dev \
    && rm -rf /var/lib/apt/lists/* \
	&& wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.gz \
	&& tar xzf nasm-2.13.03.tar.gz \
	&& cd nasm-2.13.03 \
	&& ./configure && make && make install
	

VOLUME /data/blender /data/lib /data/build

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
