include config.mk
include ../utils.mk

SECRET=0wgxR2rIVP

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME);
	if [[ ! -f "src/$(TARBALL)" ]]; then \
	  echo "ERROR: Cannot find src/$(TARBALL). You can download the latest (sic!) version of AnnoVar as:\n\n  curl -o $(TARBALL) https://www.openbioinformatics.org/annovar/download/$(SECRET)/annovar.latest.tar.gz"; \
	  exit 1; \
	fi
	cp -p src/$(TARBALL) $(BUILD_HOME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	prefix=$$(dirname $(PREFIX)); \
	tar --directory=$${prefix} -zxf $(BUILD_HOME)/$(TARBALL); \
	rmdir $(PREFIX); \
	mv $${prefix}/annovar $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
