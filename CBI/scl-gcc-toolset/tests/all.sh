#!/usr/bin/env bash
path=$(realpath "${BASH_SOURCE%/*}")

module load CBI
module load bats-core

export MODULE_NAME=scl-gcc-toolset

for version in 13 12 11 10 9; do
    export MODULE_VERSION=${version}
    echo "# Testing ${MODULE_NAME}/${MODULE_VERSION}"
    bats --timing "${path}"/modules.bats
done
