#' Example:
#' make NAME=libevent VERSION=2.1.8

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

BUILD_SUFFIX=-stable

MODULE_NAME=$(NAME)

ifndef BUILD_HOME
  BUILD_HOME=$(TMPDIR)
endif

BUILD_NAME=$(NAME)-$(VERSION)$(BUILD_SUFFIX)

BUILD_PATH=$(BUILD_HOME)/$(BUILD_NAME)

ifndef SOFTWARE_HOME
  $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
endif

ifndef PREFIX
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
endif

TARBALL=$(BUILD_NAME).tar.gz

all: debug install

debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "SOFTWARE_HOME: $(SOFTWARE_HOME)"
	@echo "PREFIX: $(PREFIX)"
	@echo "BUILD_HOME: $(BUILD_HOME)"
	@echo "BUILD_PATH: $(BUILD_PATH)"
	@echo "BUILD_SUFFIX: $(BUILD_SUFFIX)"
	@echo "BUILD_NAME: $(BUILD_NAME)"


$(BUILD_PATH):
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/libevent/libevent/releases/download/release-$(VERSION)-stable/$(TARBALL); \
	tar xvfz $(TARBALL)

dependencies:

build: $(BUILD_PATH) dependencies
	cd $(BUILD_PATH); \
	module purge; \
	./configure --prefix=$(PREFIX); \
	make

install: $(PREFIX)
	cd $(BUILD_PATH); \
	make install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

## FIXME: This fail on Wynton with:
## [msg] Nameserver 127.0.0.1:51382 has failed: request timed out.
test: $(PREFIX)
	make check
