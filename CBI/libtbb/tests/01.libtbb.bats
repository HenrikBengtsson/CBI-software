#!/usr/bin/env bats

setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

@test "libtbb exists" {
    run stat "$PREFIX/lib/libtbb.so"
    assert_success
}

@test "libtbbmalloc exists" {
    run stat "$PREFIX/lib/libtbbmalloc.so"
    assert_success
}

@test "tbb.h header exists" {
    run stat "$PREFIX/include/tbb/tbb.h"
    assert_success
}

@test "oneapi/tbb.h header exists" {
    run stat "$PREFIX/include/oneapi/tbb.h"
    assert_success
}

@test "libtbb has the modern oneTBB ABI (no classic tbb::task)" {
    run bash -c "nm -D '$PREFIX/lib/libtbb.so' | grep -c '_ZTIN3tbb4taskE'"
    assert_output "0"
}

@test "pkgconfig exists" {
    run stat "$PREFIX/lib/pkgconfig/tbb.pc"
    assert_success
}

@test "pkgconfig Libs includes an explicit -L (not just -ltbb)" {
    # A bare '-ltbb' is not enough: GCC's LIBRARY_PATH does not reliably
    # win over its own built-in /usr/lib64 search path, which silently
    # resolves to Rocky 8's system tbb 2018.2 instead of this module.
    run bash -c "PKG_CONFIG_PATH='$PREFIX/lib/pkgconfig' pkg-config --libs tbb"
    assert_success
    assert_output --partial "-L$PREFIX/lib"
}

@test "a program built via pkg-config links against this module's libtbb, not the system one" {
    cat > "$BATS_TEST_TMPDIR/tbb_test.cpp" <<'EOF'
#include <tbb/tbb.h>
int main() {
  tbb::parallel_for(0, 1, [](int) {});
  return 0;
}
EOF
    run bash -c "
      export PKG_CONFIG_PATH='$PREFIX/lib/pkgconfig'
      g++ -std=gnu++17 -DTBB \$(pkg-config --cflags tbb) \
        -o '$BATS_TEST_TMPDIR/tbb_test' '$BATS_TEST_TMPDIR/tbb_test.cpp' \
        \$(pkg-config --libs tbb) \
      && LD_LIBRARY_PATH='$PREFIX/lib' ldd '$BATS_TEST_TMPDIR/tbb_test' | grep -i libtbb.so
    "
    assert_success
    assert_output --partial "$PREFIX/lib/libtbb.so"
}
