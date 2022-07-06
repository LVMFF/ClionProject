#!/bin/bash

set -eoux pipefail

export ROOT_DIR="$(pwd)/.."
export SYSTEM_TYPE=$1       # linux 或者 win

export CPU_PROCESSOR_NUM=$(grep processor /proc/cpuinfo | wc -l)
export JOB_NUM=$(expr "${CPU_PROCESSOR_NUM}" )

echo "-------------------------------"
echo "ROOT_DIR = "${ROOT_DIR}""
echo "SYSTEM_TYPE = "${SYSTEM_TYPE}""
echo "JOB_NUM = "${JOB_NUM}""
echo "-------------------------------"

echo "Begin time:$(date "+%G-%m-%d_%H:%M:%S")"

if [ -d "${ROOT_DIR}"/build/"${SYSTEM_TYPE}" ]; then
    rm -rf "${ROOT_DIR}"/build/"${SYSTEM_TYPE}"
fi

mkdir -p "${ROOT_DIR}"/build/"${SYSTEM_TYPE}"
cd "${ROOT_DIR}"/build/"${SYSTEM_TYPE}"

# 编译代码
cmake ../.. -DSYSTEM_TYPE="${SYSTEM_TYPE}"

echo "The CMake configuration is successful."
make -j"${JOB_NUM}"
make install -j"${JOB_NUM}"

echo End time: $(date "+%G-%m-%d_%H:%M:%S")