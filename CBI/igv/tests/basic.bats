setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    module load openjdk/17
    version=$(${SOFTWARE_ROOT_CBI}/IGV-${VERSION}/igv.sh --version 2> /dev/null | grep -E "^[[:digit:].]+$")
    assert_equal "${version}" "${VERSION}"
}
