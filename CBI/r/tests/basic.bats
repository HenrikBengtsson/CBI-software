setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate Rscript executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(Rscript --version 2>&1 | sed -E 's/.*([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+).*/\1/g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate R executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(R --version | head -1 | sed -E 's/.*([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+).*/\1/g')
    assert_equal "${version}" "${VERSION}"
}

@test "validate command-line option --help" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run R --help
    assert_output --partial "Usage:"
    assert_output --partial "--help"
}


@test "Assert expected capabilities()" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run Rscript -e 'x <- capabilities(); x <- x[order(names(x))]; cat(sprintf("%s=%s", names(x), x), sep = "\n")'

    assert_output --partial "aqua=FALSE"
    assert_output --partial "cairo=TRUE"
    assert_output --partial "cledit=FALSE"
    assert_output --partial "fifo=TRUE"
    assert_output --partial "http/ftp=TRUE"
    assert_output --partial "iconv=TRUE"
    assert_output --partial "ICU=TRUE"
    assert_output --partial "jpeg=TRUE"
    assert_output --partial "libcurl=TRUE"
    assert_output --partial "libxml=FALSE"
    assert_output --partial "long.double=TRUE"
    assert_output --partial "NLS=TRUE"
    assert_output --partial "png=TRUE"
    assert_output --partial "profmem=TRUE"
    assert_output --partial "Rprof=TRUE"
    assert_output --partial "sockets=TRUE"
    assert_output --partial "tcltk=TRUE"
    assert_output --partial "tiff=TRUE"
    assert_output --partial "X11=TRUE"
}
