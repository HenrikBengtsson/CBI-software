setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
    
    if [[ -f "tests/000.init.sh" ]]; then
        source "tests/000.init.sh"
    fi
}


@test "Does not use RUNPATH" {
    local -a files
    local -a rpath_files
    local -a rpath_deps
    local -a deps
    local bfr
    
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" \( -type f -o -type l \) -executable)
    echo "Scanning ${#files[@]} executables under ${PREFIX}"
    for kk in $(seq "${#files[@]}"); do
        file=${files[$((kk-1))]}

        bfr=$(readelf -d "${file}" 2> /dev/null | grep -F "RUNPATH" || true)
        if [[ -n "${bfr}" ]]; then
            bfr=$(sed -E 's/(.*[[]|[]]$)//g' <<< "$bfr")
            mapfile -t deps < <(sed -E 's/:/\n/g' <<< "$bfr" | sort -u)
#            2>&1 echo "Detected RUNPATH in ${file}: [n=${#deps[@]}] ${deps[*]}"
            rpath_files+=("${file}")
            rpath_deps+=("${deps[@]}")
        fi
    done

    if [[ ${#rpath_deps[@]} -gt 0 ]]; then
        mapfile -t rpath_files < <(printf "%s\n" "${rpath_files[@]}" | sort -u)
        mapfile -t rpath_deps < <(printf "%s\n" "${rpath_deps[@]}" | sort -u)
        fail "[${MODULE_NAME}/${MODULE_VERSION}] Detected ${#rpath_files[@]} binaries ($(sed -E "s|${PREFIX}/||g" <<< "${rpath_files[*]}")) with RUNPATH dependencies: [n=${#rpath_deps[@]}] ${rpath_deps[*]}"
    fi
}
