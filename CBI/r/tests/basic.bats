setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate Rscript executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(Rscript --version 2>&1 | sed -E 's/.*([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+).*/\1/g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate R executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(R --version | head -1 | sed -E 's/.*([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+).*/\1/g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run R --help
    assert_output --partial "Usage:"
    assert_output --partial "--help"
}
