setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(magick -version | grep -E "^Version:" | sed 's/.*ImageMagick *//' | sed 's/ .*//')
    assert_equal "${version}" "${VERSION}"
}

@test "essential image-format delegates are available" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    formats=$(magick -list format)
    for fmt in PNG JPEG TIFF; do
        run grep -qE "^ *${fmt}\\*? " <<< "${formats}"
        assert_success
    done
}

@test "pkg-config finds Magick++" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists Magick++
    assert_success
}

@test "pkg-config reports expected Magick++ version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    ## Upstream reports either the full version (7.1.2-30) or just the
    ## base version (7.1.2) here, so only require it to be a prefix.
    version=$(pkg-config --modversion Magick++)
    assert_equal "${VERSION:0:${#version}}" "${version}"
}

@test "pkg-config points back at this module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    libdir=$(pkg-config --variable=libdir Magick++)
    assert_equal "${libdir}" "${PREFIX}/lib"
}

@test "Magick++.h can be compiled and linked against" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    cd "$(mktemp -d)"
    cat > test.cpp <<'CPP'
#include <Magick++.h>
int main() {
  Magick::InitializeMagick(nullptr);
  Magick::Image image(Magick::Geometry(2, 2), Magick::Color("red"));
  return image.columns() == 2 ? 0 : 1;
}
CPP
    run g++ $(pkg-config --cflags Magick++) test.cpp -o test $(pkg-config --libs Magick++)
    assert_success
    run ./test
    assert_success
}
