NAME=oraclejdk
VERSION=17.0.9
DOWNLOAD_TARGET_FILE=bin/java
CONFIG=false
BUILD=false
INSTALL_TARGET_FILE=bin/java

## We only want to make this available on CentOS 7,
## because on Rocky 8, we already have openjdk (>= 17)
LINUX_DISTRO_SPECIFIC=true
