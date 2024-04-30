#!/usr/bin/env bats

setup() {
  module load CBI
}

@test "${MODULE_NAME}/${MODULE_VERSION}: load & validate gcc, g++, c++, gfortan version" {
    module load "${MODULE_NAME}/${MODULE_VERSION}"
   
    run gcc --version
    [ $status -eq 0 ]
    [[ "${lines[0]}" =~ ^"gcc (GCC) ${MODULE_VERSION}"* ]]

    run g++ --version
    [ $status -eq 0 ]
    [[ "${lines[0]}" =~ ^"g++ (GCC) ${MODULE_VERSION}"* ]]

    run c++ --version
    [ $status -eq 0 ]
    [[ "${lines[0]}" =~ ^"c++ (GCC) ${MODULE_VERSION}"* ]]
   
    run gfortran --version
    [ $status -eq 0 ]
    [[ "${lines[0]}" =~ ^"GNU Fortran (GCC) ${MODULE_VERSION}"* ]]
}

