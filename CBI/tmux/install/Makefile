#' Example:
#' make VERSION=2.6

NAME=tmux

include ../../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.gz

all: debug build install

$(BUILD_PATH)/$(NAME)-$(VERSION):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/tmux/tmux/releases/download/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

build: $(BUILD_PATH)/$(NAME)-$(VERSION)
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	./configure --prefix=$(PREFIX); \
	make

install: build
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	make install
	@echo "SOFTWARE INSTALLED IN: $(PREFIX)"
