setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(gh --version | head -1 | sed -E 's/.* ([[:digit:].]+).*/\1/')
    assert_equal "${version}" "${VERSION}"
}

@test "validate help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run gh --help
    assert_output --partial "gh"
    assert_output --partial "--help"
    assert_output --partial "--version"
}
