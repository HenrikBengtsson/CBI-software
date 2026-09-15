export PREFIX

include config.mk
include ../utils.mk

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/OpenMathLib/OpenBLAS/releases/download/v$(VERSION)/OpenBLAS-$(VERSION).tar.gz; \
	tar xvfz OpenBLAS-$(VERSION).tar.gz

available-version:
	@$(MAKE) --quiet available-version-github GITHUB_REPO=OpenMathLib/OpenBLAS
