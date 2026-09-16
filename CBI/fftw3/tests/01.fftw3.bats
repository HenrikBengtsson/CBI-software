#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "fftw3 library exists" {
    run stat "$PREFIX/lib/libfftw3.so"
    assert_success
}

@test "fftw3 headers exist" {
    run stat "$PREFIX/include/fftw3.h"
    assert_success
}
