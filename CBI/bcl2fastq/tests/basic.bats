setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(bcl2fastq --version 2>&1 | grep bcl2fastq | sed 's/.* v//'| sed -E 's/[.][[:digit:]]+$//')
    assert_equal "${version}" "${VERSION}"
}
