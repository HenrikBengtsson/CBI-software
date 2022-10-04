NAME=rstudio-server
VERSION=2022.02.4-500
## VERSION=2022.07.2-576 # broken, cf. https://github.com/HenrikBengtsson/CBI-software/issues/78
DOWNLOAD_TARGET_FILE=INSTALL
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/src/cpp/server/crash-handler-proxy/crash-handler-proxy
INSTALL_TARGET_FILE=bin/rserver
CONFIG_MODULES=CBI cmake jq scl-devtoolset r

