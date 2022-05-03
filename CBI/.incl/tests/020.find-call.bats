@test "can find binary" {
    if [[ -x "${INSTALL_TARGET}" ]]; then
       module load "${MODULE_REPO}"
       if ${MODULE_HIDDEN}; then
           module load "${MODULE_NAME}/.${VERSION}"
       else
           module load "${MODULE_NAME}"
       fi
       command -v "$(basename "${INSTALL_TARGET}")"
    fi
}
