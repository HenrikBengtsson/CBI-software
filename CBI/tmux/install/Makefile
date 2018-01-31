#' Example:
#' make VERSION=2.6

SHELL=bash

NAME=tmux
MODULE_NAME=$(NAME)

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

ifndef BUILD_PATH
  BUILD_PATH=$(TMPDIR)
endif

ifndef SOFTWARE_HOME
  $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
endif

ifndef PREFIX
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
endif


TARBALL=$(NAME)-$(VERSION).tar.gz

all: debug build install

debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "SOFTWARE_HOME: $(SOFTWARE_HOME)"
	@echo "PREFIX: $(PREFIX)"
	@echo "BUILD_PATH: $(BUILD_PATH)"

$(BUILD_PATH)/$(NAME)-$(VERSION):
	cd $(BUILD_PATH); \
	curl --insecure -L -O https://github.com/tmux/tmux/releases/download/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

build: $(BUILD_PATH)/$(NAME)-$(VERSION)
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	./configure --prefix=$(PREFIX); \
	make

install: build
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	make install
	@echo "SOFTWARE INSTALLED IN: $(PREFIX)"
