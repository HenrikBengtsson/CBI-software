-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /opt/rh/python33/enable
prepend_path("LD_LIBRARY_PATH","/opt/rh/python33/root/usr/lib64")
prepend_path("MANPATH","/opt/rh/python33/root/usr/share/man")
prepend_path("PATH","/opt/rh/python33/root/usr/bin")
setenv("PKG_CONFIG_PATH","/opt/rh/python33/root/usr/lib64/pkgconfig")
setenv("XDG_DATA_DIRS","/opt/rh/python33/root/usr/share")
