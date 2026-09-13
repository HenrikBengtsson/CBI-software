include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/nextflow-io/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p "$(@D)"
	if curl --fail --silent --head "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)-$(VERSION)-dist" > /dev/null; then \
	  curl -L -o "$@" "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)-$(VERSION)-dist"; \
	elif curl --fail --silent --head "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)-$(VERSION)-all" > /dev/null; then \
	  curl -L -o "$@" "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)-$(VERSION)-all"; \
	else \
	  curl -L -o "$@" "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)"; \
	fi
	chmod ugo+x "$@"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(@D)"
	cp -p "$<" "$@"
	make post_install
	ls -la "$(PREFIX)"
	ls -la "$(@D)"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
