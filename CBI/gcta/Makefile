include config.mk
include ../utils.mk

ZIPBALL=$(NAME)_$(VERSION).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	if [[ $(VERSION) == 1.26.0 ]]; then \
	  cd $(BUILD_HOME); \
	  curl -L -O http://cnsgenomics.com/software/gcta/pre_gcta/$(ZIPBALL); \
	  mkdir $(NAME)-$(VERSION); \
	  cd $(NAME)-$(VERSION); \
	  unzip ../$(ZIPBALL); \
	else \
	  cd $(BUILD_HOME); \
	  curl -L -O http://cnsgenomics.com/software/gcta/bin/$(ZIPBALL); \
	  unzip $(ZIPBALL); \
	  mv $(NAME)_$(VERSION) $(NAME)-$(VERSION); \
	fi

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mv $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
