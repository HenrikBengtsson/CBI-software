-- Don't edit! Created using: 
-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /software/c4/cbi/software/miniconda3-22.11.1-1-py310/etc/profile.d/conda.sh
pushenv("CONDA_EXE","/software/c4/cbi/software/miniconda3-22.11.1-1-py310/bin/conda")
pushenv("CONDA_PYTHON_EXE","/software/c4/cbi/software/miniconda3-22.11.1-1-py310/bin/python")
pushenv("CONDA_SHLVL","0")
prepend_path("PATH","/software/c4/cbi/software/miniconda3-22.11.1-1-py310/condabin")
pushenv("_CE_CONDA","")
pushenv("_CE_M","")
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
    ( \"$CONDA_EXE\" $_CE_M $_CE_CONDA \"$@\" )\
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
