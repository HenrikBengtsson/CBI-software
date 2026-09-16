setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


## -----------------------------------------------------------------
## protobuf-compiler half
## -----------------------------------------------------------------
@test "protoc is installed and reports this version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run protoc --version
    assert_success
    assert_output --partial "${MODULE_VERSION}"
}

@test "protoc on PATH is the one from THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run command -v protoc
    assert_success
    assert_output "${PREFIX:?}/bin/protoc"
}


## -----------------------------------------------------------------
## protobuf-devel half
## -----------------------------------------------------------------
@test "shared libraries are installed" {
    run stat "${PREFIX:?}/lib/libprotobuf.so"
    assert_success
    run stat "${PREFIX:?}/lib/libprotoc.so"
    assert_success
}

@test "pkg-config file is installed" {
    run stat "${PREFIX:?}/lib/pkgconfig/protobuf.pc"
    assert_success
}

@test "pkg-config resolves protobuf to THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists protobuf
    assert_success
    prefix=$(pkg-config --variable=prefix protobuf)
    assert_equal "${prefix}" "${PREFIX}"
}

## protobuf.pc's 'Requires:' names ~36 absl_* modules plus utf8_range, and
## pkg-config resolves the whole chain or nothing.  A single missing absl_*.pc
## therefore breaks every consumer -- including every R package whose configure
## runs 'pkg-config --libs protobuf' -- while the three tests above still pass.
## This is the test that catches a half-installed abseil.
@test "pkg-config resolves the full Requires: chain" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --print-errors --cflags --libs protobuf
    assert_success
    assert_output --partial "-lprotobuf"
}

## Abseil is not a separate module: protobuf links it and names it in
## protobuf.pc, so it has to be installed into this same tree.
@test "abseil is installed alongside protobuf" {
    run stat "${PREFIX:?}/lib/pkgconfig/absl_strings.pc"
    assert_success
    run stat "${PREFIX:?}/include/absl/strings/string_view.h"
    assert_success
}


## -----------------------------------------------------------------
## Both halves together -- what an R package such as 'protolite' does:
## run protoc to generate C++, then compile and link it against libprotobuf
## using the flags pkg-config hands out.
## -----------------------------------------------------------------
@test "protoc output compiles, links and runs" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    cat > cbi.proto <<'EOF'
syntax = "proto3";
message CBI {
  string name = 1;
}
EOF
    run protoc --cpp_out=. cbi.proto
    assert_success
    assert_file_exists cbi.pb.cc
    assert_file_exists cbi.pb.h

    cat > main.cpp <<'EOF'
#include <iostream>
#include "cbi.pb.h"
int main() {
  CBI msg;
  msg.set_name("protobuf");
  std::string wire;
  if (!msg.SerializeToString(&wire)) return 1;
  CBI copy;
  if (!copy.ParseFromString(wire)) return 1;
  std::cout << copy.name() << std::endl;
  return 0;
}
EOF
    run bash -c '${CXX:-g++} -std=c++17 -o roundtrip main.cpp cbi.pb.cc $(pkg-config --cflags --libs protobuf)'
    assert_success

    run ./roundtrip
    assert_success
    assert_output "protobuf"
}
