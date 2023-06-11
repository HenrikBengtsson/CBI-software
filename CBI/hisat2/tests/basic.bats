setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(hisat2 --version | head -1 | sed 's/.* //')
    assert_equal "${version}" "${VERSION}"
}


@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run "${MODULE_NAME}" --help
    assert_output --partial "${MODULE_NAME}"
    assert_output --partial "--help"
    assert_output --partial "Usage:"
}
