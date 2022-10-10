setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "can execute 'ctop -V'" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run ctop -V
    assert_success
}
