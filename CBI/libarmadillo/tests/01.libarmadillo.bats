#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "library exists" {
    run stat "$PREFIX/lib64/libarmadillo.so"
    assert_success
}

@test "header exists" {
    run stat "$PREFIX/include/armadillo"
    assert_success
}

@test "pkgconfig exists" {
    run stat "$PREFIX/lib64/pkgconfig/armadillo.pc"
    assert_success
}
