#' Example:
#' make VERSION=2.6

include ../../utils.mk

all: debug build check install

$(BUILD_PATH)/$(NAME)-$(VERSION):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -O http://hisham.hm/htop/releases/$(VERSION)/$(TARBALL); \
	tar -xvzf $(TARBALL)

build: $(BUILD_PATH)/$(NAME)-$(VERSION)
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	./configure --prefix=$(PREFIX); \
	make

check: build
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	make check

install: build
	cd $(BUILD_PATH)/$(NAME)-$(VERSION); \
	make install
	@echo "SOFTWARE INSTALLED IN: $(PREFIX)"
