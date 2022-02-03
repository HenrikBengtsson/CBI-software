[![shellcheck](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/shellcheck.yml)
[![luacheck](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/luacheck.yml/badge.svg)](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/luacheck.yml)

# The UCSF Computation Biology Core (CBI) Software Repository

## File-system layout

* `SOFTWARE_ROOT_CBI`: This is the folder where all CBI software are installed
* `MODULE_ROOT_CBI`: This is the folder where all CBI modules are installed

For example, on the Wynton HPC environment, these are:

```sh
SOFTWARE_ROOT_CBI=/wynton/home/cbi/shared/software/CBI
MODULE_ROOT_CBI=/wynton/home/cbi/shared/modulefiles/CBI
```

and on the C4 environment, they are:

```sh
SOFTWARE_ROOT_CBI=/software/c4/cbi/software
MODULE_ROOT_CBI=/software/c4/cbi/modulefiles
```


## Install the CBI repository module

To build the `CBI.lua` repository module and install it to `${MODULE_ROOT_CBI}/repos/`, do:

```sh
$ make install
```

If installing to a system other than the Wynton HPC and C4, make sure to set up:

```sh
SOFTWARE_ROOT_CBI=/path/to/software
MODULE_ROOT_CBI=/path/to/modulefiles
```

To test it, try with:

```sh
$ module show CBI
```

If the module cannot be found, make sure it's on the `MODULE_PATH` search path, e.g. by prepending it as `MODULE_PATH=${MODULE_ROOT_CBI}/repos:${MODULE_PATH}`.  This should be set configured centrally on the system, e.g. via `/etc/profile`.


## Install individual CBI software tools and modules

_Note: In order to install individual CBI modules and the corresponding software tools, `module load CBI` must work._

Here is an example how to install the latest version of the **bat** software, so that it's available via `module load CBI bat`.

```sh
$ cd CBI/bat/
$ make
```

This will download the software, extract it, and install it to `${SOFTWARE_ROOT_CBI}/bat-<version>/`. The corresponding module file will be installed to `${MODULE_ROOT_CBI}/bat/<version>.lua`.  Some software like **bat** is prebuilt for Linux when downloaded, whereas other software like **R** will be built from source code.

_Comment: All modules have been verified to install on the Wynton HPC and the C4 environments.  These are both running CentOS 7 and are configured similarly.  So of the software has also been verified to install on Ubuntu 18.04._

