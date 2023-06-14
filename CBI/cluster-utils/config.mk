NAME=cluster-utils

## 'ctop -V' for VERSION=23.04.1 gives:
## Can't locate Curses.pm in @INC (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5
## /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .)
## at /wynton/home/cbi/shared/software/CBI/cluster-utils-23.04.1/bin/ctop line 71.
## BEGIN failed--compilation aborted at
## /wynton/home/cbi/shared/software/CBI/cluster-utils-23.04.1/bin/ctop line 71.
## VERSION=23.04.1

VERSION=23.03.1
URL_DOWNLOAD=https://github.com/molgenis/cluster-utils/releases/
URL=https://github.com/molgenis/cluster-utils/releases/
DOWNLOAD_TARGET_FILE=bin/ctop
CONFIG=false
BUILD=false
INSTALL_TARGET_FILE=bin/ctop
