setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(tea --version | head -1 | sed -E 's/\x1b\[[0-9;]*m//g' | sed -E 's/Version:[[:space:]]*//' | sed -E 's/[[:space:]]+.*//')
    assert_equal "${version}" "${VERSION}"
}

@test "validate help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run tea --help
    assert_output --partial "tea"
    assert_output --partial "--help"
}
