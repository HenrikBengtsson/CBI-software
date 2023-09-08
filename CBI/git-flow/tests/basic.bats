setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(git flow version | sed -E 's/ .*//')
    assert_equal "${version}" "${VERSION}"
}

@test "validate command-line help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run git flow
    assert_output --partial "git flow"
    assert_output --partial "usage:"
}
