include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/genome/${NAME}/archive/v${VERSION}.tar.gz; \
	tar zxf v${VERSION}.tar.gz;
## WORKAROUND: Not gcc 4.8.5, but newer compilers give:
## error: call of overloaded ‘abs(unsigned int)’ is ambiguous
	sed -i 's/abs[(]/abs((long int)/g' $(BUILD_PATH)/src/*.cpp;


ifeq ($(VERSION),0.2.4t)
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module --force purge; \
	cd $(BUILD_PATH); \
	module load samtools/0.1.18; \
	module list; \
	SAMTOOLS_HOME="$$(dirname $$(dirname $$(which samtools)))"; \
	echo "SAMTOOLS_HOME=$${SAMTOOLS_HOME}"; \
	LIBRARY_PATH=$${SAMTOOLS_HOME}/lib ./INSTALL $${SAMTOOLS_HOME}/include;
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
