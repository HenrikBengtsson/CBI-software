#' Example:
#' make VERSION=2.6

NAME=tmux

include ../utils.mk

all: debug install

install_software:
	cd install; \
	make NAME=$(NAME)

install_module:
	cd module; \
	make NAME=$(NAME)

install: install_software install_module
