setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate that Java (<= 1.*) detects _JAVA_OPTIONS" {
    local ver=$(java -version 2>&1 | head -1)
    if ! grep -q -E "\b1[.]" <<< "${ver}"; then
        skip "_JAVA_OPTIONS is only set by '${MODULE_NAME}' when running Java (<= 1.*): ${ver}"
    fi
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run java -version
    assert_output --partial "_JAVA_OPTIONS"
    assert_output --partial "${_JAVA_OPTIONS}"
    assert_output --partial "${TMPDIR}"
}



@test "validate that Java (>= 9) detects JDK_JAVA_OPTIONS" {
    module try-load openjdk/17
    module try-load openjdk/11
    local ver=$(java -version 2>&1 | head -1)
    if grep -q -E "\b1[.]" <<< "${ver}"; then
        skip "JDK_JAVA_OPTIONS is only set by '${MODULE_NAME}' when running Java (<= 1.*): ${ver}"
    fi
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run java -version
    assert_output --partial "JDK_JAVA_OPTIONS"
    assert_output --partial "${JDK_JAVA_OPTIONS}"
    assert_output --partial "${TMPDIR}"
}
