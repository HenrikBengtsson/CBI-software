[![shellcheck](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/shellcheck.yml)
[![luacheck](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/luacheck.yml/badge.svg)](https://github.com/HenrikBengtsson/CBI-software/actions/workflows/luacheck.yml)

# The UCSF Computation Biology Core (CBI) Software Repository

## Setup

### Requirements

This repository requires:

* Lmod (>= 8.6)

_Comments_: We're deploying to two different CentOS 7.9 systems running Lmod 8.7.7 and Bash 4.2.46.


### Configure installation (always)

Make sure to set environment variables `MODULE_HOME` and `SOFTWARE_HOME` to point to the folders where environment modules and software tools should be installed. For example, on the Wynton HPC environment, these are:

```sh
SOFTWARE_HOME=/wynton/home/cbi/shared/software/CBI
MODULE_HOME=/wynton/home/cbi/shared/modulefiles/CBI
```

and on the C4 environment, they are:

```sh
SOFTWARE_HOME=/software/c4/cbi/software
MODULE_HOME=/software/c4/cbi/modulefiles
```

These are only need to be set during installation. They are not needed when users use the CBI software stack.


### Install the CBI repository module (once)

To build the `CBI.lua` repository module and install it to `${MODULE_HOME}/repos/CBI.lua`, do:

```sh
$ make install
```

### Configure MODULEPATH for all users

For users to get access to the CBI software stack, the above `CBI.lua` must be on the `MODULEPATH`. This can be by prepending folder `${MODULE_HOME}/repos/` to the `MODULEPATH` environment variable in a `/etc/profile.d/` script, e.g.


```sh
$ cat /etc/profile.d/lmod_custom.sh
MODULEPATH="/software/c4/cbi/modulefiles/repos:$MODULEPATH"
export MODULEPATH
```

To verify that `CBI.lua` can be found, open a new shell and call:

```sh
$ module show CBI
```

Note that this `MODULEPATH` allows for sibling software stacks next to the CBI stack, i.e. other groups will be able to share their software tools by adding a `${MODULE_HOME}/repos/{GROUP-NAME}.lua`.


### Install individual CBI software tools

_Note: In order to install individual CBI modules and the corresponding software tools, above `module load CBI` must work._

Here is an example how to install the latest version of the **bat** software, so that it's available via `module load CBI bat`.

```sh
$ cd CBI/bat/
$ make all
```

This will download the software, extract it, and install it to `${SOFTWARE_HOME}/bat-<version>/`. The corresponding module file will be installed to `${MODULE_HOME}/bat/<version>.lua`.  Some software like **bat** is prebuilt for Linux when downloaded, whereas other software like **R** will be built from source code.

_Comment: All modules have been verified to install on the Wynton HPC and the C4 environments.  These are both running CentOS 7 and are configured similarly.  Some of the software has also been verified to install on Ubuntu 18.04 and Ubuntu 20.04._
