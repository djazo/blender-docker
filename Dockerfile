# Docker image for building blender for linux

FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y --no-install-recommends \
	autoconf \
	automake \
	bison \
	ca-certificates \
	cmake \
	diffutils \
	flex \
	g++ \
	gawk \
	gcc \
	gettext \
	git \
	libbz2-dev \
	libc-dev \
	libfreetype6-dev \
	libsdl1.2-dev \
	libsqlite3-dev \
	libssl-dev \
	libtinyxml-dev \
	libtool \
	libxcursor-dev \
	libxi-dev \
	libxinerama-dev \
	libxml2-dev \
	libxrandr-dev \
	libyaml-cpp-dev \
	make \
	nasm \
	patchutils \
	tcl-dev \
	wget \
	yasm && \
	rm -rf /var/lib/apt/lists/* && \
	update-alternatives --install /usr/bin/python python /usr/bin/python3 1

VOLUME /data

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
