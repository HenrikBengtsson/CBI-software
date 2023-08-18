setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


@test "No missing library dependencies" {
    local -a files
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    mapfile -t files < <(find "${PREFIX}" -type f -executable)
    echo "Scanning ${#files[@]} executable files under $home"
    mapfile -t missing < <(ldd "${files[@]}" 2>&1 | grep -F "not found" | sed -E "s/(^${PREFIX//\//\\/}[^[:space:]]+:[[:space:]]+|^[[:space:]]+| => .*| not found .*)//g" | sort -u | sed -E 's/: (version.*)/ [\1]/g' | sort -h)

    [[ ${#missing[@]} == 0 ]] || fail "Detected missing library dependencies: [n=${#missing[@]}] ${missing[*]}"
}
