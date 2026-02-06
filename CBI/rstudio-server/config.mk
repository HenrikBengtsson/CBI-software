NAME=rstudio-server

## If you get an error that yarn cannot access the registry (e.g. timeout)
## then it could be because of a slow network or a slow file system.
## Increasing the timeout can help. To do that set:
## $ yarn config set network-timeout 1000000

VERSION=2025.09.1-401
VERSION=2026.01.0-392

# last version that install out of the box for now
VERSION=2025.05.1-513


DOWNLOAD_TARGET_FILE=INSTALL
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/src/cpp/server/crash-handler-proxy/crash-handler-proxy
INSTALL_TARGET_FILE=bin/rserver

## Rocky 8.10 comes with cmake 3.26.5. Ubuntu 22.04 comes with cmake 3.22.1.
## Both are sufficient for installing v2025.05.0-496 /HB 2025-05-16
## Need CMake (>= 3.5 && < 3.30), because CMake (>= 3.30) triggers a
##   false positive error on CMake (>= 3.5) is required (sic!) /HB 2026-02-06
CONFIG_MODULES=CBI jq scl-devtoolset r cmake/3.29.9 apache-ant sqlite/3.29.9
