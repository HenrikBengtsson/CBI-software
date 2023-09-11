include config.mk
include ../utils.mk

TARBALL=$(NAME)_linux-v$(VERSION).tar.gz
GITHUB_REPO=https://github.com/alexdobin/STAR

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/$(VERSION).zip; \
	unzip $(VERSION).zip

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	mv bin/Linux_x86_64_static/STAR bin/STAR.hide; \
	mv bin/Linux_x86_64_static/* bin/; \
	rm -rf bin/{Linux_x86_64,Linux_x86_64_static,MacOSX_x86_64}; \
	rm .gitignore .gitmodules .travis.yml _config.yml; \
	mv bin/STAR.hide bin/STAR

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
