#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "executable exists" {
    run stat "$PREFIX/bin/glpsol"
    assert_success
}

@test "executable can be run" {
    run "$PREFIX/bin/glpsol" --version
    assert_success
}

@test "library exists" {
    run stat "$PREFIX/lib/libglpk.so"
    assert_success
}

@test "header exists" {
    run stat "$PREFIX/include/glpk.h"
    assert_success
}
