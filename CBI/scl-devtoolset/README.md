# scl-devtoolset

The `scl-devtoolset/{{version}}.lua` environment modules applies the same settings as `scl enable scl-devtoolset-{{version}} ${SHELL}` but to the current shell avoiding the need to open a new shell.


## Translate SCL to Lmod

[Lmod] provides a tool `sh_to_modulefile` that takes an SCL "enable" script and outputs Lmod environment module commands.  This script is _not_ on the `PATH`, but it can be found at:

```sh
$ "${LMOD_DIR}/sh_to_modulefile"
```

where `LMOD_DIR` should be set by Lmod, e.g. on CentOS 7.9 and Ubuntu 18.04:

```sh
$ echo "${LMOD_DIR}"
/usr/share/lmod/lmod/libexec
```

For example, consider the following SCL "enable" script for SCL devtoolset-9:

```sh
$ cat /opt/rh/devtoolset-9/enable
# General environment variables
export PATH=/opt/rh/devtoolset-9/root/usr/bin${PATH:+:${PATH}}
export MANPATH=/opt/rh/devtoolset-9/root/usr/share/man:${MANPATH}
export INFOPATH=/opt/rh/devtoolset-9/root/usr/share/info${INFOPATH:+:${INFOPATH}}
export PCP_DIR=/opt/rh/devtoolset-9/root
# bz847911 workaround:
# we need to evaluate rpm's installed run-time % { _libdir }, not rpmbuild time
# or else /etc/ld.so.conf.d files?
rpmlibdir=$(rpm --eval "%{_libdir}")
# bz1017604: On 64-bit hosts, we should include also the 32-bit library path.
if [ "$rpmlibdir" != "${rpmlibdir/lib64/}" ]; then
  rpmlibdir32=":/opt/rh/devtoolset-9/root${rpmlibdir/lib64/lib}"
fi
export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root$rpmlibdir$rpmlibdir32:/opt/rh/devtoolset-9/root$rpmlibdir/dyninst$r
pmlibdir32/dyninst${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PKG_CONFIG_PATH=/opt/rh/devtoolset-9/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}
```

This script can be transpiled to Lmod commands as:

```lua
$ (module purge; INFOPATH=DUMMY LD_LIBRARY_PATH=DUMMY PKG_CONFIG_PATH=DUMMY "${LMOD_DIR}/sh_to_modulefile" /opt/rh/devtoolset-9/enable | grep -vF DUMMY)
prepend_path("INFOPATH","/opt/rh/devtoolset-9/root/usr/share/info")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-9/root/usr/lib/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-9/root/usr/lib64/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-9/root/usr/lib")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-9/root/usr/lib64")
append_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-9/root/usr/lib")
prepend_path("MANPATH","/opt/rh/devtoolset-9/root/usr/share/man")
prepend_path("PATH","/opt/rh/devtoolset-9/root/usr/bin")
setenv("PCP_DIR","/opt/rh/devtoolset-9/root")
prepend_path("PKG_CONFIG_PATH","/opt/rh/devtoolset-9/root/usr/lib64/pkgconfig")
```

Comment: The reason for those `ABC=DUMMY` environment variables is to make the corresponding variables be set with `prepend_path()` and not `setenv()` as intended.  At the moment, I don't fully understand why this is needed, but I suspect it has to do with the special `${ABC:+:$ABC}` syntax that the input shell script uses.  It could be that the `sh_to_modulefile` tool does not recognize them.  We use Lmod 8.1.2. /HB 2021-12-17

With these commands, we can create an module environment file.  See [CBI/scl-devtoolset/9.lua](9.lua) for an example.


[Lmod]: https://lmod.readthedocs.org
