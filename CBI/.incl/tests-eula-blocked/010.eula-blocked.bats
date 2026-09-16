setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"

    ## The mockup module only warns while it is being installed, cf.
    ## 'utils/eula_blocked.lmod.tmpl'
    unset MODULE_INSTALLATION
}

@test "has correct input" {
    [[ -n ${MODULE_REPO} ]] || { 2>&1 echo "MODULE_REPO is not set"; exit 1; }
    [[ -n ${MODULE_NAME} ]] || { 2>&1 echo "MODULE_NAME is not set"; exit 1; }
    [[ -n ${LMOD_CMD} ]] || { 2>&1 echo "LMOD_CMD is not set"; exit 1; }
}

@test "software is not installed" {
    if [[ -n "${PREFIX}" ]]; then
        assert_file_not_exist "${PREFIX}"
    fi
}

@test "can show module" {
    if [[ -n "${MODULE_REPO}" ]]; then
        module load "${MODULE_REPO}"
    fi
    run module --ignore-cache show "${MODULE_NAME}/${MODULE_VERSION}"
    assert_success
    assert_output --partial "EULA"
}

@test "cannot load module, and it explains why" {
    if [[ -n "${MODULE_REPO}" ]]; then
        module load "${MODULE_REPO}"
    fi
    run "${LMOD_CMD:?}" bash load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_failure
    assert_output --partial "is not installed on this system"
    assert_output --partial "EULA"
}

@test "module is not loaded after a failed attempt" {
    if [[ -n "${MODULE_REPO}" ]]; then
        module load "${MODULE_REPO}"
    fi
    module load "${MODULE_NAME}/${MODULE_VERSION}" || true
    run module --terse list
    refute_output --partial "${MODULE_NAME}/${MODULE_VERSION}"
}
