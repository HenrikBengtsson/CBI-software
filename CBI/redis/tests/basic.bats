setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate redis-cli executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(redis-cli --version | sed 's/.* //')
    assert_equal "${version}" "${VERSION}"
}

@test "validate redis-server executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(redis-server --version | sed 's/.*v=//' | sed 's/ .*//')
    assert_equal "${version}" "${VERSION}"
}


@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run "redis-server" --help
    assert_output --partial "redis-server"
    assert_output --partial "--help"
    assert_output --partial "Usage:"
}
