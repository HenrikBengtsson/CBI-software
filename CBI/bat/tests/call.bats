source "000.init.sh"

@test "can find binary" {
    module load "${MODULE_REPO}" "${MODULE_NAME}"
    command -v "${SOFTWARE_BINARY}"
}

@test "can call binary" {
    module load "${MODULE_REPO}" "${MODULE_NAME}"
    "${SOFTWARE_BINARY}" --version
}
