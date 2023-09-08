setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate that Java detects _JAVA_OPTIONS" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run java -version
    assert_output --partial "_JAVA_OPTIONS"
    assert_output --partial "${_JAVA_OPTIONS}"
    assert_output --partial "${TMPDIR}"
}
