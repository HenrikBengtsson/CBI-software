#' Example:
#' make VERSION=5.124

include ../../utils.mk

TARBALL=$(NAME)_$(VERSION)$(BUILD_SUFFIX).orig.tar.gz

all: debug install

$(BUILD_PATH):
	mkdir -p $(BUILD_HOME); \
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
