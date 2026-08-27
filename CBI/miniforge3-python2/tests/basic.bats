setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate Python is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    ## Python 2 reports its version on stderr
    version=$(python --version 2>&1 | sed 's/.* //')
    assert_equal "${version}" "${VERSION}"
}

@test "python is Python 2" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run python -c 'import sys; print(sys.version_info[0])'
    assert_output "2"
}
