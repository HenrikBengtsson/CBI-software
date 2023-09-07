NAME=sqlite

## Release history: https://sqlite.org/changes.html
## There's no 'make test' in 3.14.0 :(
VERSION=3.14.0
VERSION_ID=3140000
VERSION_YEAR=2016

## There's no 'make test' in 3.31.1 :(
VERSION=3.31.1
VERSION_ID=3310100
VERSION_YEAR=2020

## There's no 'make test' in 3.30.1 :(
VERSION=3.30.1
VERSION_ID=3300100
VERSION_YEAR=2019

## There's no 'make test' in 3.32.3 :(
VERSION=3.32.3
VERSION_ID=3320300
VERSION_YEAR=2020

## With 3.34.1, 'make test' gives:
## ./testfixture: version conflict for package "Tcl": have 8.5.13, need 8.6
#VERSION=3.34.1
#VERSION_ID=3340100
#VERSION_YEAR=2021

VERSION=3.40.0
VERSION_ID=3400000
VERSION_YEAR=2022

VERSION=3.41.1
VERSION_ID=3410100
VERSION_YEAR=2023

VERSION=3.41.2
VERSION_ID=3410200
VERSION_YEAR=2023

VERSION=3.42.0
VERSION_ID=3420000
VERSION_YEAR=2023

VERSION=3.43.0
VERSION_ID=3430000
VERSION_YEAR=2023

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

URL_DOWNLOAD=https://sqlite.org/download.html

DOWNLOAD_TARGET_FILE=configure
BUILD_TARGET_FILE=sqlite3
INSTALL_TARGET_FILE=bin/sqlite3
