setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(git filter-repo --help | tail -1 | sed -E 's/[^[:digit:]]*(([[:digit:]]+)([.][[:digit:]]+)+).*/\1/g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate command-line help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run git filter-repo --help
    assert_output --partial "GIT-FILTER-REPO"
    assert_output --partial "SYNOPSIS"
}
