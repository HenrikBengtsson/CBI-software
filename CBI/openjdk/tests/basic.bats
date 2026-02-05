setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(java -version 2>&1 | head -1 | sed -E 's/^([[:alpha:] "])+//' | sed -E 's/".*//')
    VERSION=$(echo "${VERSION}" | sed -E 's/[+][[:digit:]]+$//')
    assert_equal "${version}" "${VERSION}"
}


@test "validate javac is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(javac -version | sed -E 's/^([[:alpha:] "])+//' | sed -E 's/".*//')
    VERSION=$(echo "${VERSION}" | sed -E 's/[+][[:digit:]]+$//')
    assert_equal "${version}" "${VERSION}"
}
