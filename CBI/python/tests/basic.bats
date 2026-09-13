setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "validate python3 executable is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(python3 --version | sed 's/.* //')
    assert_equal "${version}" "${VERSION}"
}

@test "validate unversioned python is of expected version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    version=$(python --version | sed 's/.* //')
    assert_equal "${version}" "${VERSION}"
}

@test "validate pip is available and works" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    pip --version
}

@test "validate standard library imports" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    python3 -c "import sys, os, math, ssl, sqlite3, zlib, tkinter; print('ok')"
}
