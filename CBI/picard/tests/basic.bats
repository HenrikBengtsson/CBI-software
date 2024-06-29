setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable outputs help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run java -jar "$PICARD_HOME/picard.jar" -h 2>&1
    assert_output --partial "USAGE: PicardCommandLine"
}

@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run bash -c 'java -jar "$PICARD_HOME/picard.jar" MarkDuplicates --version 2>&1 | grep -v -F "_JAVA_OPTIONS" | sed "s/Version://g"'
    assert_output --regexp "^${VERSION}"
}

@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run java -jar "$PICARD_HOME/picard.jar" -h
    assert_output --partial "PicardCommandLine"
    assert_output --partial "USAGE:"
}
