include config.mk

VERSION_UNDERSCORE := $(shell echo "$(VERSION)" | sed -E 's/[.]/_/g')
TARBALL=GISTIC_$(VERSION_UNDERSCORE).tar.gz
DOWNLOAD_TARGET_FILE:=$(TARBALL)

include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O ftp://ftp.broadinstitute.org/pub/GISTIC2.0/$(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cd $(PREFIX); \
	tar -xzf $(BUILD_PATH)/$(TARBALL)
	cd $(PREFIX)/MCR_Installer; \
	unzip MCRInstaller.zip; \
	./install -mode silent -agreeToLicense yes -destinationFolder "$(PREFIX)/MATLAB_Compiler_Runtime"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	cd "$(PREFIX)"; \
	sed 's/MCR_ROOT=/PREFIX=$$(dirname "$$(readlink -e "$$0")")\nMCR_ROOT=/' gistic2 > gistic2.tmp; \
	sed -i 's/MCR_ROOT=`pwd`/MCR_ROOT=$${PREFIX}/' gistic2.tmp; \
	sed -i 's/.\/gp_gistic2_from_seg/$${PREFIX}\/gp_gistic2_from_seg/' gistic2.tmp; \
	chmod ugo+x gistic2.tmp; \
	cp gistic2 gistic2.org; \
	mv gistic2.tmp gistic2
