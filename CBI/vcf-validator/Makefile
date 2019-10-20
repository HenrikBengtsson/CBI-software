include config.mk
include ../utils.mk

VERSION_:=$(subst .,_,$(VERSION))
ZIPBALL=$(NAME)_v$(VERSION_)_core.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)/$(NAME)-$(VERSION)
	cd $(BUILD_HOME)/$(NAME)-$(VERSION); \
	curl -L -O https://github.com/EBIvariation/vcf-validator/releases/download/v$(VERSION)/vcf_assembly_checker_linux; \
	curl -L -O https://github.com/EBIvariation/vcf-validator/releases/download/v$(VERSION)/vcf_debugulator_linux; \
	curl -L -O https://github.com/EBIvariation/vcf-validator/releases/download/v$(VERSION)/vcf_validator_linux

$(BUILD_TARGET):
	mkdir -p $(BUILD_HOME)/$(NAME)-$(VERSION)/build
	cd $(BUILD_HOME)/$(NAME)-$(VERSION); \
	for ff in *_linux; do \
	  mv "$${ff}" "build/$${ff%_linux}"; \
	  chmod ugo+x "build/$${ff%_linux}"; \
	done

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION)/build $(SOFTWARE_HOME)/$(NAME)-$(VERSION)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
