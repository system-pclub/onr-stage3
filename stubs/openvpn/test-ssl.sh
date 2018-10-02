#!/usr/bin/env bash

WORK=$(pwd)
SCRIPTS_HOME=$(pwd)/../../scripts
BUILD_HOME=${SCRIPTS_HOME}/build
TEST_PROGRAM=${WORK}/ssl.bc

# get llvm executable path
LLVM_EXE="$(llvm-config --bindir)"

# run the target pass
${LLVM_EXE}/opt -load ${BUILD_HOME}/lib/DemoPass/libDemoPass.so -dump-function -strFunctionName "tls_process"  ${TEST_PROGRAM} > /dev/null
