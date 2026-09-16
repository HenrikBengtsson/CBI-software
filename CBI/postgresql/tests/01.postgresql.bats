#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "psql exists and is executable" {
    run stat "$PREFIX/bin/psql"
    assert_success
}

@test "pg_config exists and is executable" {
    run stat "$PREFIX/bin/pg_config"
    assert_success
}

@test "libpq.a exists" {
    run stat "$PREFIX/lib/libpq.a"
    assert_success
}
