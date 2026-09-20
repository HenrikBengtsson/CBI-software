#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "executable exists" {
    run stat "$PREFIX/bin/seqkit"
    assert_success
}

@test "seqkit version" {
    run "$PREFIX/bin/seqkit" version
    assert_success
    assert_output --partial "$VERSION"
}
