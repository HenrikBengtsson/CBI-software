setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(conda --version | sed 's/.* //')
    truth=$(echo "${VERSION}" | sed -E 's/-.*$//')
    assert_equal "${version}" "${truth}"
}


@test "validate python3 executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(python3 --version | sed 's/.* //' | sed 's/[.]//' | sed 's/[.].*//g')
    truth=$(echo "${VERSION}" | sed -E 's/^.*-//' | sed 's/py//')
    assert_equal "${version}" "${truth}"
}
