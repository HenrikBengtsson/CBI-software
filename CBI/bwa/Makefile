include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/lh3/bwa

## bwa (< 0.7.18)
TARBALL=$(NAME)-$(VERSION).tar.bz2
URL=https://sourceforge.net/projects/bio-bwa/files/$(TARBALL)/download
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -j -L -O $(URL); \
	mv download $(TARBALL); \
	tar xf $(TARBALL)

## bwa (>= 0.7.18)
TARBALL=v$(VERSION).tar.gz
URL=$(GITHUB_REPO)/archive/refs/tags/$(TARBALL)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar xf $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	module --force purge; \
	make; \
	mkdir -p man/man1/; \
	ln -s ../../bwa.1 man/man1/bwa.1
	make post_build

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	module --force purge; \
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
