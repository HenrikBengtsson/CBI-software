setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
    
    if [[ -f "tests/000.init.sh" ]]; then
        source "tests/000.init.sh"
    fi
}


@test "No absolute paths" {
    local -a files
    local -a missing
    local -a missing_files
    
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" -type f -executable)
    
    echo "Scanning ${#files[@]} executables under ${PREFIX}"
    for kk in $(seq "${#files[@]}"); do
        file=${files[$((kk-1))]}
        if grep -q -F "${PREFIX}" "${file}" 2>&1; then        
            file=$(sed "s|${PREFIX}|\$PREFIX|g" <<< "${file}")
#            2>&1 echo "ABSOLUTE PATH: ${file}"
            missing_files+=("${file}")
        fi	  
    done

    if [[ ${#missing_files[@]} -gt 0 ]]; then
        fail "[${MODULE_NAME}/${MODULE_VERSION}] Detected absolute paths in executables: [n=${#missing_files[@]}] ${missing_files[*]}"
    fi
}
