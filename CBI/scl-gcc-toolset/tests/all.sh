#!/usr/bin/env bash
path=$(realpath "${BASH_SOURCE%/*}")

module load CBI
module load bats-core

for version in 9 10 11 12; do
  echo "# Testing ${MODULE_NAME}/${version}"
  bats --timing "${path}"/modules.bats
done
