NAME=rstudio-server

## If you get an error that yarn cannot access the registry (e.g. timeout)
## then it could be because of a slow network or a slow file system.
## Increasing the timeout can help. To do that set:
## $ yarn config set network-timeout 1000000

VERSION=2024.12.0-467

DOWNLOAD_TARGET_FILE=INSTALL
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/src/cpp/server/crash-handler-proxy/crash-handler-proxy
INSTALL_TARGET_FILE=bin/rserver
CONFIG_MODULES=CBI cmake jq scl-devtoolset r

