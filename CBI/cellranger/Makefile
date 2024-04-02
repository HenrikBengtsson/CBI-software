include config.mk
include ../utils.mk

#ifndef ACCESS_TOKEN
#  $(error "ERROR: Environment variable 'ACCESS_TOKEN' is not set. Go to https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest, fill out the form, submit, the cut&paste the URL to environment variable 'ACCESS_TOKEN' and rerun")
#endif

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
## Doesn't work, I think
#$(DOWNLOAD_TARGET):
#	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	ACCESS_TOKEN="$${ACCESS_TOKEN#?*\?}"; \
	echo "ACCESS_TOKEN=$${ACCESS_TOKEN}"; \
        URL="https://cf.10xgenomics.com/releases/cell-exp/$(NAME)-$(VERSION).tar.gz?$${ACCESS_TOKEN}"; \
	echo "URL=$${URL}"; \
	curl -o $(TARBALL) "$${URL}"; \
	tar xzf $(TARBALL)

$(TARBALL):
	$(error "Go to https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest, fill out the form, and download CellRanger as '$@' to $(PWD), e.g. cut'n'pasting the 'curl' or 'wget' command provided.")

$(BUILD_HOME)/$(TARBALL): $(TARBALL)
	mkdir -p $(BUILD_HOME); \
	cp -p "$<" "$@"

$(DOWNLOAD_TARGET): $(BUILD_HOME)/$(TARBALL)
	cd $(BUILD_HOME); \
	tar xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -p -R $(BUILD_HOME)/$(NAME)-$(VERSION) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


available-version:
	@curl --silent https://www.10xgenomics.com/support/software/cell-ranger/downloads | sed -E 's/.*cellranger-([[:digit:].]+)[.]tar[.]gz.*/\1/g'

