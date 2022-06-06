setup() {
    load "${BATS_SUPPORT_HOME}/load.bash"
    load "${BATS_ARRAY_HOME}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(cmake --version | head -1 | sed 's/.* //g')
    assert_equal "${version}" "${VERSION}"
}
