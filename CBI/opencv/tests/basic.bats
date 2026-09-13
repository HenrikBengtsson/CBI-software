setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "validate library exists" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_file_exists "${PREFIX}/lib64/libopencv_core.so"
}

@test "validate pkg-config works" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --modversion opencv4
    assert_success
    assert_output "${VERSION}"
}
