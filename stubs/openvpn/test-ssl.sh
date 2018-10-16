#!/usr/bin/env bash

WORK=$(pwd)
SCRIPTS_HOME=$(pwd)/../../scripts
BUILD_HOME=${SCRIPTS_HOME}/build
TEST_PROGRAM=${WORK}/openvpn.0.0.preopt.bc
OUTPUT_PATH=${WORK}/generate-state-machine-graph/
# get llvm executable path
LLVM_EXE="$(llvm-config --bindir)"

# run the target pass
${LLVM_EXE}/opt -load ${BUILD_HOME}/lib/FSMExtractor/libFSMExtractorPass.so -fsm-extract -strFunctionName "tls_process" -strOutFilePath ${OUTPUT_PATH}  ${TEST_PROGRAM} > /dev/null
