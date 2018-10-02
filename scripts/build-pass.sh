#!/usr/bin/env bash

WORK=$(pwd)

# enter current dir
cd ${WORK}
# make a build dir
mkdir -p ${WORK}/build

# cd build
cd ${WORK}/build
# cmake

cmake ../../

# build
make
