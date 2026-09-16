setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "shared library is installed" {
    run stat "${PREFIX:?}/lib/libhiredis.so"
    assert_success
}

@test "pkg-config file is installed" {
    run stat "${PREFIX:?}/lib/pkgconfig/hiredis.pc"
    assert_success
}

## R packages such as 'redux' locate hiredis via pkg-config; without a
## discoverable hiredis.pc they fall back to /usr/include/hiredis and fail.
##
## Assert the PREFIX that pkg-config resolves to, not the version: upstream
## derives hiredis.pc's version from HIREDIS_MAJOR/MINOR/PATCH in hiredis.h,
## which lags the release tag (the v1.4.1 tag declares 1.4.0), and a version
## check cannot tell our hiredis apart from some other one on the system.
@test "pkg-config resolves hiredis to THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists hiredis
    assert_success
    prefix=$(pkg-config --variable=prefix hiredis)
    assert_equal "${prefix}" "${PREFIX}"
}
