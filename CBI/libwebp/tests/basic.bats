setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(cwebp -version | head -n 1)
    assert_equal "${version}" "${VERSION}"
}

@test "pkg-config finds all libraries that 'ragg' asks for" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    for lib in libwebp libwebpmux libwebpdemux; do
        run pkg-config --exists "${lib}"
        assert_success
    done
}

@test "pkg-config reports expected libwebp version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(pkg-config --modversion libwebp)
    assert_equal "${version}" "${VERSION}"
}

@test "pkg-config points back at this module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    libdir=$(pkg-config --variable=libdir libwebp)
    assert_equal "${libdir}" "${PREFIX}/lib"
}

@test "encode.h can be compiled and linked against" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    cd "$(mktemp -d)"
    cat > test.c <<'C'
#include <webp/encode.h>
#include <webp/mux.h>
int main() {
  return (WebPGetEncoderVersion() > 0 && WebPGetMuxVersion() > 0) ? 0 : 1;
}
C
    run gcc $(pkg-config --cflags libwebp libwebpmux) test.c -o test $(pkg-config --libs libwebp libwebpmux)
    assert_success
    run ./test
    assert_success
}
