include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O "http://ftp.midnight-commander.org/$(NAME)-$(VERSION).tar.xz"; \
	tar xfJ "$(NAME)-$(VERSION).tar.xz"

post_config:
	sed -n '/^Configuration:/,/^##/p' "$(BUILD_PATH)/config.log" | grep -vE "^##" > $(BUILD_PATH)/config.summary

post_install:
	cp "$(BUILD_PATH)/config.summary" "$(PREFIX)"
