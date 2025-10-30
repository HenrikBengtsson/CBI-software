setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate 'cargo' executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(cargo --version | sed -E 's/(^[^ ]+ | .*)//g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate 'rustc' executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(cargo --version | sed -E 's/(^[^ ]+ | .*)//g')
    assert_equal "${version}" "${VERSION}"
}
