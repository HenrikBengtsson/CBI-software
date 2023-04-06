setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(java -jar "$SNPEFF_HOME/snpEff/snpEff.jar" -version | grep SnpEff | sed -E 's/(SnpEff[[:space:]]+|[[:space:]]+.*)//g')
    assert_equal "${version}" "${VERSION}"
}
