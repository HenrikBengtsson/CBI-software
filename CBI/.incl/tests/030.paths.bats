setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"

    assert_path_exist() {
        local name=${1:?}
        local path=${!name}
        local path0=${2}

        ## Nothing to do?
        if [[ "${path}" == "${path0}" ]]; then
            skip "was not modified"
        fi

        ## Assert that the path is appended or prepended, but not messed
        ## with internally, i.e. 'path0' is fully contained in 'path'.
    #    if ! grep -q -E "(^|:)$path0(:|$)" <<< "$path"; then
    #      fail "Detected '${name}' componments that were neither appended nor prepended: $path0 -> $path"
    #    fi

        IFS=':' read -r -a path <<< "$path"
        for p in "${path[@]}"; do
            grep -q -E "(^|:)${p}(:|$)" <<< "$path0" && continue
            assert_dir_exist "$p"
        done
    }
}

@test "validate PATH" {
    name="PATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate MANPATH" {
    name="MANPATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate LD_LIBRARY_PATH" {
    name="LD_LIBRARY_PATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate PKG_CONFIG_PATH" {
    name="PKG_CONFIG_PATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate LD_RUN_PATH" {
    name="LD_RUN_PATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate CPATH" {
    name="CPATH"
    module purge
    path_org="${!name}"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

