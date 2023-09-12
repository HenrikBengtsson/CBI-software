setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(gatk -version 2> /dev/null | head -1 | sed 's/.* v//')
    assert_equal "${version}" "${VERSION}"
}


@test "validate empty call (no options)" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run gatk
    assert_output --partial "gatk"
    assert_output --partial "--help"
}


@test "validate gatk --list" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run gatk --list
    assert_output --partial "USAGE:"
    assert_output --partial "Available Programs:"
}
