NAME=rstudio-server

## If you get an error that yarn cannot access the registry (e.g. timeout)
## then it could be because of a slow network or a slow file system.
## Increasing the timeout can help. To do that set:
## $ yarn config set network-timeout 1000000

## VERSION=2022.07.2-576 # broken, cf. https://github.com/HenrikBengtsson/CBI-software/issues/78
## Works: VERSION=2022.12.0-353
VERSION=2023.06.1+524
DOWNLOAD_TARGET_FILE=INSTALL
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/src/cpp/server/crash-handler-proxy/crash-handler-proxy
INSTALL_TARGET_FILE=bin/rserver
CONFIG_MODULES=CBI cmake jq scl-devtoolset r

