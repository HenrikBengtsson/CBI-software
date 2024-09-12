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
    local -a missing_files
    local -a unique_kinds
    
    if [[ -n "${MODULE_REPO}" ]]; then
        module load "${MODULE_REPO}"
    fi
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" -type f -executable)
    
    echo "Scanning ${#files[@]} executables under ${PREFIX}"
    for kk in $(seq "${#files[@]}"); do
        file=${files[$((kk-1))]}
        if grep -q -F "${PREFIX}" "${file}" 2>&1; then        
            kind="$(file --brief --mime "${file}")"
            unique_kinds+=("${kind}")
            file=$(sed "s|${PREFIX}|\$PREFIX|g" <<< "${file}")
#            2>&1 echo "ABSOLUTE PATH: ${file} [${kind}]"
            missing_files+=("${file} [${kind}]")
        fi
    done

    if [[ ${#missing_files[@]} -gt 0 ]]; then
        mapfile -t unique_kinds < <(printf "%s\n" "${unique_kinds[@]}" | sort -u)
        2>&1 echo        
        2>&1 echo "Type of files:"
        for kk in $(seq "${#unique_kinds[@]}"); do
            kind=${unique_kinds[$((kk-1))]}
#            2>&1 printf "%s\n" "${missing_files[@]}" | grep -F "${kind}"
            mapfile -t files < <(printf "%s\n" "${missing_files[@]}" | grep -F "${kind}" | sed -E "s| *[[]${kind}[]]||g")
           2>&1 printf "  %d. %s: [n=%d] %s\n" "${kk}" "${kind}" "${#files[@]}" "${files[*]}"
        done
        2>&1 echo        
        fail "[${MODULE_NAME}/${MODULE_VERSION}] Detected absolute paths in executables: [n=${#missing_files[@]}] $(echo "${missing_files[*]}" | sed -E "s| *[[][^]]*[]]||g")"
    fi
}
