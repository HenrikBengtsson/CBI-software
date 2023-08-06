setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(ASCIIGenome --version | sed -E 's/.* //')
    assert_equal "${version}" "${VERSION}"
}



@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run ASCIIGenome --help
    assert_output --partial "ASCIIGenome"
    assert_output --partial "--help"
}
