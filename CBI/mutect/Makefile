include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)-bin.zip
URL=https://github.com/broadinstitute/mutect/releases/download/$(VERSION)/$(TARBALL)

ifeq ($(VERSION),1.0.27783)
  TARBALL=muTect-$(VERSION)-bin.zip
  URL=src/$(TARBALL)
else ifeq ($(VERSION),1.1.1)
  TARBALL=muTect-$(VERSION)-bin.zip
  URL=https://software.broadinstitute.org/cancer/cga/sites/default/files/data/tools/mutect/$(TARBALL)
else ifeq ($(VERSION),1.1.4)
  TARBALL=muTect-$(VERSION)-bin.zip
  URL=https://software.broadinstitute.org/cancer/cga/sites/default/files/data/tools/mutect/$(TARBALL)
endif


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME);
ifeq ($(VERSION),1.0.27783)
	echo "VERSION=$(VERSION)"
	echo "$(URL)"
	[[ -f "$(URL)" ]] || { echo "ERROR: Cannot find $(URL). This is version is unfortunately available online, cf. https://gatk.broadinstitute.org/hc/en-us/community/posts/4408026763803-Download-muTect-1-0-27783-jar-"; exit 1; }
	cp -p $(URL) $(BUILD_HOME)
else
	cd $(BUILD_HOME); \
	curl -L -O "$(URL)"
endif
	cd $(BUILD_HOME); \
	unzip -d "$(BUILD_NAME)" "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
