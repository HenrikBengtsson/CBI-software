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

@test "CONDA_OFFLINE is unset by default" {
    unset NO_INTERNET
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_equal "${CONDA_OFFLINE:-}" ""
}

@test "NO_INTERNET=true sets CONDA_OFFLINE=true" {
    export NO_INTERNET=true
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_equal "${CONDA_OFFLINE:-}" "true"
    unset NO_INTERNET
}
