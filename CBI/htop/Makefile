include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ifeq ($(VERSION),2.2.0)
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O http://hisham.hm/htop/releases/$(VERSION)/$(TARBALL); \
	tar xfz "$(TARBALL)"
else
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L https://bintray.com/htop/source/download_file?file_path=$(TARBALL) -o $(TARBALL); \
	tar xfz $(TARBALL)
endif
