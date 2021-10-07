include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz
## v0.2.4.tar.gz provides 0.2.4w, whereas r0.2.4.tar.gz provides 0.2.4t :/
ifeq ($(VERSION),0.2.4t)
TARBALL=r$(VERSION).tar.gz
endif
URL=https://github.com/genome/${NAME}/archive/$(TARBALL)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar zxf $(TARBALL);
ifeq ($(VERSION),0.2.4t)
	mv "$(BUILD_HOME)/$(NAME)-r0.2.4t" "$(BUILD_PATH)"
endif
## WORKAROUND: Not gcc 4.8.5, but newer compilers give:
## error: call of overloaded ‘abs(unsigned int)’ is ambiguous
## Source: https://github.com/genome/pindel/pull/102
	sed -i 's/abs[(]/abs((long int)/g' $(BUILD_PATH)/src/*.cpp;

ifeq ($(VERSION),0.2.4t)
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module --force purge; \
	cd $(BUILD_PATH); \
	module load samtools/0.1.18; \
	module list; \
	SAMTOOLS_HOME="$$(dirname $$(which samtools))"; \
	echo "SAMTOOLS_HOME=$${SAMTOOLS_HOME}"; \
	LIBRARY_PATH=$${SAMTOOLS_HOME} ./INSTALL $${SAMTOOLS_HOME};
else
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module --force purge; \
	cd $(BUILD_PATH); \
	module load htslib; \
	module list; \
	SAMTOOLS_HOME="$$(dirname $$(dirname $$(which htsfile)))"; \
	echo "SAMTOOLS_HOME=$${SAMTOOLS_HOME}"; \
	LIBRARY_PATH=$${SAMTOOLS_HOME}/lib ./INSTALL $${SAMTOOLS_HOME};
endif

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
