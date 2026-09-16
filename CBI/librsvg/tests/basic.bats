setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate rsvg-convert executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run rsvg-convert --version
    assert_output --partial "${VERSION}"
}

@test "pkg-config finds librsvg-2.0" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists librsvg-2.0
    assert_success
}

@test "pkg-config reports expected librsvg-2.0 version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(pkg-config --modversion librsvg-2.0)
    assert_equal "${version}" "${VERSION}"
}

@test "pkg-config points back at this module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    libdir=$(pkg-config --variable=libdir librsvg-2.0)
    assert_equal "${libdir}" "${PREFIX}/lib"
}

@test "rsvg.h can be compiled and linked against" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    
    cd "$(mktemp -d)"
    cat > test.c <<'C'
#include <librsvg/rsvg.h>
int main() {
    /* Simple initialization call or just checking if header works */
    return 0;
}
C
    run gcc $(pkg-config --cflags librsvg-2.0) test.c -o test $(pkg-config --libs librsvg-2.0)
    assert_success
    run ./test
    assert_success
}
