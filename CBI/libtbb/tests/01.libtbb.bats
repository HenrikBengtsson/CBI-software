#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "libtbb exists" {
    run stat "$PREFIX/lib/libtbb.so"
    assert_success
}

@test "libtbbmalloc exists" {
    run stat "$PREFIX/lib/libtbbmalloc.so"
    assert_success
}

@test "tbb.h header exists" {
    run stat "$PREFIX/include/tbb/tbb.h"
    assert_success
}

@test "oneapi/tbb.h header exists" {
    run stat "$PREFIX/include/oneapi/tbb.h"
    assert_success
}

@test "libtbb has the modern oneTBB ABI (no classic tbb::task)" {
    run bash -c "nm -D '$PREFIX/lib/libtbb.so' | grep -c '_ZTIN3tbb4taskE'"
    assert_output "0"
}
