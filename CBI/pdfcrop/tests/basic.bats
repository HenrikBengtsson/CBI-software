setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(pdfcrop --version | sed 's/.* v//g')
    assert_equal "${version}" "${VERSION}"
}


@test "validate expected help output" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pdfcrop --help
    assert_success
    assert_output --partial "--help"
    assert_output --partial "PDFCROP"
}
