setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate command-line help output" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run gistic2
    assert_output --partial "Setting Matlab MCR root"
    assert_output --partial "$(dirname "$(command -v gistic2)")"
    assert_output --partial "$(dirname "$(command -v gistic2)")/MATLAB_Compiler_Runtime"
    assert_output --partial "Usage:"
    assert_output --partial "gp_gistic2_from_seg"
}
