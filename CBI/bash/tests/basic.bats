setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(bash --version | head -1 | sed 's/.*version //' | sed 's/[^[:digit:].].*//')
    [[ "${version}" == "${VERSION}"* ]]
}

@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run bash --help
    assert_output --partial "Usage:"
    assert_output --partial "--help"
}


