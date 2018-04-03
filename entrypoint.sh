#!/bin/bash

# Entrypoint script for building blender from source.

DATA_DIR="/data"
BLENDER_SRC_DIR="/data/blender"
BLENDER_BUILD_DIR="/data/build"
LIB_BUILD_DIR="/data/build-lib"
LIB_DIR="/data/lib/linux_x86_64"
MAXTHREADS=$(grep -c ^processor /proc/cpuinfo)

function build_libs() {
  if [ ! -d ${LIB_BUILD_DIR} ]; then
    mkdir -p ${LIB_BUILD_DIR}
  fi
  cd ${LIB_BUILD_DIR}
  cmake ${BLENDER_SRC_DIR}/build_files/build_environment -DLIBDIR=${LIB_DIR} -DDOWNLOAD_DIR=${LIB_BUILD_DIR}/Download -DHARVEST_TARGET=${LIB_DIR}
  make -j${MAXTHREADS} install
}

function config_blender() {
  if [ ! -d ${BLENDER_BUILD_DIR} ]; then
    echo "Can't find Build dir. Mount it to ${BLENDER_BUILD_DIR}"
  fi
  if [ ! -d ${BLENDER_SRC_DIR} ]; then
    echo "Can't find Blender source. Pull them first or mount it to ${BLENDER_SRC_DIR}"
    exit 1
  fi
  if [ ! -d ${LIB_DIR} ]; then
    echo "Can't find libraries, build them first or mount it to that ${LIB_DIR} exists"
    exit 1
  fi
  cd ${BLENDER_BUILD_DIR}

# openal seems to be the only one that cmake can't set correctly, doing manually that.

  cmake ${BLENDER_SRC_DIR} -C${BLENDER_SRC_DIR}/build_files/cmake/config/blender_release.cmake -DWITH_PLAYER=OFF \
    -DOPENAL_LIBRARY=${LIB_DIR}/openal/lib/libopenal.a -DOPENAL_INCLUDE_DIR=${LIB_DIR}/openal/include
}

function build_blender() {
  config_blender
  cd ${BLENDER_BUILD_DIR}
  make -j${MAXTHREADS} install
}


# Actually do something on start

if [ "$1" = 'build' ]; then
  build_blender
elif [ "$1" = 'buildlibs' ]; then
  build_libs
else
  exec "$@"
fi
