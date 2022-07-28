-- Don't edit! Created using: 
-- /home/hb/shared/software/CBI/lmod-8.6/lmod/lmod/libexec/sh_to_modulefile /home/hb/shared/software/CBI/miniconda3-py39-4.12.0/etc/profile.d/conda.sh
set_shell_function("__add_sys_prefix_to_path"," \
    if [ -n \"${_CE_CONDA}\" ] && [ -n \"${WINDIR+x}\" ]; then\
        SYSP=$(\\dirname \"${CONDA_EXE}\");\
    else\
        SYSP=$(\\dirname \"${CONDA_EXE}\");\
        SYSP=$(\\dirname \"${SYSP}\");\
    fi;\
    if [ -n \"${WINDIR+x}\" ]; then\
        PATH=\"${SYSP}/bin:${PATH}\";\
        PATH=\"${SYSP}/Scripts:${PATH}\";\
        PATH=\"${SYSP}/Library/bin:${PATH}\";\
        PATH=\"${SYSP}/Library/usr/bin:${PATH}\";\
        PATH=\"${SYSP}/Library/mingw-w64/bin:${PATH}\";\
        PATH=\"${SYSP}:${PATH}\";\
    else\
        PATH=\"${SYSP}/bin:${PATH}\";\
    fi;\
    \\export PATH\
","")
set_shell_function("__conda_activate"," \
    if [ -n \"${CONDA_PS1_BACKUP:+x}\" ]; then\
        PS1=\"$CONDA_PS1_BACKUP\";\
        \\unset CONDA_PS1_BACKUP;\
    fi;\
    \\local ask_conda;\
    ask_conda=\"$(PS1=\"${PS1:-}\" __conda_exe shell.posix \"$@\")\" || \\return;\
    \\eval \"$ask_conda\";\
    __conda_hashr\
","")
set_shell_function("__conda_exe"," \
    ( __add_sys_prefix_to_path;\
    \"$CONDA_EXE\" $_CE_M $_CE_CONDA \"$@\" )\
","")
set_shell_function("__conda_hashr"," \
    if [ -n \"${ZSH_VERSION:+x}\" ]; then\
        \\rehash;\
    else\
        if [ -n \"${POSH_VERSION:+x}\" ]; then\
            :;\
        else\
            \\hash -r;\
        fi;\
    fi\
","")
set_shell_function("__conda_reactivate"," \
    \\local ask_conda;\
    ask_conda=\"$(PS1=\"${PS1:-}\" __conda_exe shell.posix reactivate)\" || \\return;\
    \\eval \"$ask_conda\";\
    __conda_hashr\
","")
set_shell_function("conda"," \
    \\local cmd=\"${1-__missing__}\";\
    case \"$cmd\" in \
        activate | deactivate)\
            __conda_activate \"$@\"\
        ;;\
        install | update | upgrade | remove | uninstall)\
            __conda_exe \"$@\" || \\return;\
            __conda_reactivate\
        ;;\
        *)\
            __conda_exe \"$@\"\
        ;;\
    esac\
","")
