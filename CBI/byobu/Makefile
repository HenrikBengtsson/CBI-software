#' Example:
#' make VERSION=5.124

NAME=byobu

include ../utils.mk

all: debug install

install_software:
	cd install; \
	make NAME=$(NAME)

install_module:
	cd module; \
	make NAME=$(NAME)

install: install_software install_module
