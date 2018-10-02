#!/usr/bin/env bash

WORK=$(pwd)
BUILD_HOME=$(pwd)/../../scripts/build/lib
TEST_PROGRAM=${WORK}/test-demo.bc

LLVM_EXE="$(llvm-config --bindir)"

 ${LLVM_EXE}/opt -load ${BUILD_HOME}/DemoPass/libDemoPass.so -print-main  ${TEST_PROGRAM} > /dev/null
