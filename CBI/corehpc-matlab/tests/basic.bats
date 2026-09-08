setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "matlab is on the PATH after loading the module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run command -v matlab
    assert_success
}

@test "matlab reports the expected release" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run matlab -batch "disp(version('-release'))"
    assert_success
    assert_output --partial "${VERSION#R}"
}
