#!/usr/bin/env bats

setup() {
  module load CBI
}

@test "${MODULE_NAME}/${MODULE_VERSION}: load & validate gcc version" {
   module load "${MODULE_NAME}/${MODULE_VERSION}"
   run gcc --version
   [ $status -eq 0 ]
   [[ "${lines[0]}" =~ ^"gcc (GCC) ${MODULE_VERSION}"* ]]
}

