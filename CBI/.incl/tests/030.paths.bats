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

        local -a missing
        IFS=':' read -r -a dirs <<< "$path"
        for dir in "${dirs[@]}"; do
            ## Check only folder under SOFTWARE_HOME
            if [[ "$dir" == "$SOFTWARE_HOME"* ]]; then
#               grep -q -E "(^|:)${dir}(:|$)" <<< "$path0" && continue
                [[ -d "${dir}" ]] || missing+=( "$dir" )
            fi
        done
        [[ ${#missing[@]} == 0 ]] || fail "Detected non-existing folder(s) in ${name}: [n=${#missing[@]}] ${missing[*]}"
    }

    if [[ -f "tests/000.init.sh" ]]; then
        source "tests/000.init.sh"
    fi
}


@test "validate PATH" {
    name="PATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate MANPATH" {
    name="MANPATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate LD_LIBRARY_PATH" {
    name="LD_LIBRARY_PATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate PKG_CONFIG_PATH" {
    name="PKG_CONFIG_PATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate LD_RUN_PATH" {
    name="LD_RUN_PATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

@test "validate CPATH" {
    name="CPATH"
    path_org="${!name}"
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    assert_path_exist "${name}" "${path_org}"
}

