include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(INSTALL_TARGET):
	mkdir -p "$(PREFIX)"
	module load $(BUILD_MODULES); \
	GOBIN=$(PREFIX) go install github.com/psanford/wormhole-william@v$(VERSION)
	ln -s $(PREFIX)/$(NAME) $(PREFIX)/wormhole
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
