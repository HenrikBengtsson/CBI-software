source "000.init.sh"

@test "can call binary" {
    module load "${MODULE_REPO}" "${MODULE_NAME}"
    "${SOFTWARE_BINARY}" --version
}
