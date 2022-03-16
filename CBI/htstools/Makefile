include config.mk
include ../utils.mk

NAME2=snp_pileup
TARBALL=$(NAME2)_$(VERSION).tar.gz



## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/mskcc/htstools/archive/refs/tags/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv "$(NAME)-$(NAME2)_$(VERSION)" "$(NAME)-$(VERSION)"

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module load htslib; \
	cd $(BUILD_PATH); \
	for name in dnafrags ppflag-fixer snp-pileup; do \
	  g++ -std=c++11 "$${name}.cpp" -o "$${name}" -lhts $$(pkg-config --libs htslib --cflags); \
	done

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p "$(PREFIX)"
	cp $(BUILD_PATH)/{dnafrags,ppflag-fixer,snp-pileup} "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
