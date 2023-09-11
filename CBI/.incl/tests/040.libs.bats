setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "No missing library dependencies" {
    local -a files
    local -a missing
    local -a missing_libs
    local -a missing_files
    module load "${MODULE_REPO}"
    module load "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" -type f -executable)
    echo "Scanning ${#files[@]} executable files under $home"
    for kk in $(seq "${#files[@]}"); do
      file=${files[$((kk-1))]}
      mapfile -t missing < <(ldd "${file}" 2>&1 | grep -F "not found" | sed -E "s/(^${PREFIX//\//\\/}[^[:space:]]+:[[:space:]]+|^[[:space:]]+| => .*| not found .*)//g" | sort -u | sed -E 's/: (version.*)/ [\1]/g' | sort -h)
      if [[ ${#missing[@]} -gt 0 ]]; then
          2>&1 echo "MISSING LIBRARY: ${file}: [n=${#missing[@]}] ${missing[*]}"
          missing_files+=("${file}")
          missing_libs+=("${missing[@]}")
      fi	  
    done

    [[ ${#missing_libs[@]} == 0 ]] || fail "Detected missing library dependencies in ${#missing_files[@]} executables (${missing_files[*]}): [n=${#missing_libs[@]}] ${missing_libs[*]}"
}
