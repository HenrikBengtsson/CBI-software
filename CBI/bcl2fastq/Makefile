include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tgz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	echo VERSION=${VERSION}; \
	version=${VERSION}; \
	fullname=${NAME}2-v$${version//./-}; \
	curl -L -O ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/${NAME}/$${fullname}-tar.zip; \
	unzip $${fullname}-tar.zip; \
	tar vxf ${NAME}2-v${VERSION}.*-Source.tar.gz; \
	mv ${NAME} ${BUILD_PATH}

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	module purge
	cd $(BUILD_PATH); \
	mkdir bcl2fastq-build; \
	cd bcl2fastq-build; \
	../src/configure $(CONFIG_OPTS) --prefix=$(PREFIX)

$(BUILD_TARGET): $(CONFIG_TARGET)
	module purge;
	cd $(BUILD_PATH)/bcl2fastq-build; \
	make $(BUILD_OPTS)
	make post_build

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(SOFTWARE_HOME)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/bcl2fastq-build; \
	make install
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
