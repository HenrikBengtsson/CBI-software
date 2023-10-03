setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(mosh --version | head -1 | sed -E 's/(^[^ ]+ | .*)//g')
    assert_equal "${version}" "${VERSION}"
}


@test "validate help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run mosh --help
    assert_output --partial "mosh"
    assert_output --partial "Usage:"
    assert_output --partial "--help"
}
