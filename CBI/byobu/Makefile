#' Example:
#' make VERSION=5.124

NAME=byobu

all: debug install

debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"

install_software:
	cd install; \
	make

install_module:
	cd module; \
	make

install: install_software install_module
