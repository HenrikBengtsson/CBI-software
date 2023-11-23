include config.mk
include ../utils.mk

URL_PATH=https://github.com/mrtazz/checkmake/releases/download/$(VERSION)
## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)/{bin,share/man/man1}
	cd $(BUILD_PATH); \
	(cd share/man/man1 && curl -L -O $(URL_PATH)/$(NAME).1) && \
	(cd bin && curl -L -o $(NAME) $(URL_PATH)/$(NAME)-$(VERSION).linux.amd64)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)/..
	cp -R "$(BUILD_PATH)" $(PREFIX)/..
	chmod ugo+x "$@"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
