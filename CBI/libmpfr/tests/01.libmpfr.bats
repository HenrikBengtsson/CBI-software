#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "library exists" {
    assert_file_exists "$PREFIX/lib/libmpfr.so"
}

@test "header exists" {
    assert_file_exists "$PREFIX/include/mpfr.h"
}
