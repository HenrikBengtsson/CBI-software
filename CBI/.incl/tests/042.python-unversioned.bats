setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
    
    if [[ -f "tests/000.init.sh" ]]; then
        source "tests/000.init.sh"
    fi
}


@test "No shebang with unversioned 'python'" {
    local -a files
    local -a missing_files
    local -a unique_kinds
    
    if [[ -n "${MODULE_REPO}" ]]; then
        module load "${MODULE_REPO}"
    fi
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" -type f -executable)
    
    echo "Scanning ${#files[@]} for 'python' in shebang"
    for kk in $(seq "${#files[@]}"); do
        file=${files[$((kk-1))]}
        if head -n 1 "${file}" | grep -q -E "#!.*\bpython\b" 2>&1; then
            file=$(sed "s|${PREFIX}|\$PREFIX|g" <<< "${file}")
            2>&1 echo " - ${file}"
            missing_files+=("${file}")
        fi
    done

    if [[ ${#missing_files[@]} -gt 0 ]]; then
        fail "[${MODULE_NAME}/${MODULE_VERSION}] Detected shebangs with unversioned 'python': [n=${#missing_files[@]}] $(echo "${missing_files[*]}" | sed -E "s| *[[][^]]*[]]||g")"
    fi
}
