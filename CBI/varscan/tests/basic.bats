setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(pattern="^VarScan v([[:digit:]]+([.][[:digit:]]+)+).*"; java -jar "$VARSCAN_HOME/VarScan.jar" 2>&1 | grep -E "$pattern" | sed -E "s/$pattern/\1/")
    assert_equal "${version}" "${VERSION}"
}
