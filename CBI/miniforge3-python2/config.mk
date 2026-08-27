NAME=miniforge3-python2

## The CBI 'miniforge3' module used to create the Python 2 environment
#MINIFORGE3_VERSION=26.3.2-3

## Python 2 version to install (2.7.15 is the last Python 2.7 on conda-forge)
PYTHON_VERSION=2.7.15

VERSION=$(PYTHON_VERSION)
MODULE_HIDDEN=false

DOWNLOAD=false
CONFIG=false
BUILD=false
INSTALL_TARGET_FILE=bin/python2.7
