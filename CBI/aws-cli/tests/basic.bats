setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(aws --version | grep -E "^aws-cli" | sed -E 's/^aws-cli[/]([^ ]+) .*/\1/')
    assert_equal "${version}" "${VERSION}"
}
