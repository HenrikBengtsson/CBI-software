#' Example:
#' make VERSION=5.124

NAME=byobu

MODULE_NAME=$(NAME)

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

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

TARBALL=$(NAME)_$(VERSION)$(BUILD_SUFFIX).orig.tar.gz

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
	@echo "TARBALL: $(TARBALL)"


$(BUILD_PATH):
	cd $(BUILD_HOME); \
	curl --insecure -L -O https://launchpad.net/byobu/trunk/$(VERSION)/+download/$(TARBALL); \
	tar xvfz $(TARBALL)

download: $(BUILD_PATH)

$(PREFIX): $(BUILD_PATH)
	cd $(BUILD_PATH); \
	./configure --prefix=$(PREFIX); \
	make

build: $(PREFIX)

install: build
	cd $(BUILD_PATH); \
	make install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED IN: $(PREFIX)"

test: $(PREFIX)
	make check
