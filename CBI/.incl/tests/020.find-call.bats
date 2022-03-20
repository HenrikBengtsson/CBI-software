@test "can find binary" {
    if [[ -x "${INSTALL_TARGET}" ]]; then
        module load "${MODULE_REPO}" "${MODULE_NAME}"
        command -v "${INSTALL_TARGET_NAME}"
        command -v "${INSTALL_TARGET_NAME}"
    fi
}
