setup() {
    load "${BATS_SUPPORT_HOME}/load.bash"
    load "${BATS_ARRAY_HOME}/load.bash"
}

@test "has correct input" {
    [[ -n ${MODULE_REPO} ]] || { 2>&1 echo "MODULE_REPO is not set"; exit 1; }
    [[ -n ${MODULE_NAME} ]] || { 2>&1 echo "MODULE_NAME is not set"; exit 1; }
}

@test "can load module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
}

@test "can unload module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    module unload "${MODULE_NAME}"
}
