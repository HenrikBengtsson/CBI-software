setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
    
    if [[ -f "tests/000.init.sh" ]]; then
        source "tests/000.init.sh"
    fi
}

@test "can find install target" {
    assert_file_exist "${INSTALL_TARGET}"
}

@test "can execute install target, if binary" {
    if [[ -x "${INSTALL_TARGET}" ]]; then
        if [[ -n "${MODULE_REPO}" ]]; then
            module load "${MODULE_REPO}"
        fi
        module load "${MODULE_NAME}/${MODULE_VERSION}"
        command -v "$(basename "${INSTALL_TARGET}")"
    fi
}
