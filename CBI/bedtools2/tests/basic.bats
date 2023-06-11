setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(bedtools --version | sed 's/.* v//')
    assert_equal "${version}" "${VERSION}"
}


@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run bedtools --help
    assert_output --partial "bedtools"
    assert_output --partial "--help"
    assert_output --partial "Usage:"
}
