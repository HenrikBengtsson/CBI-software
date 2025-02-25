include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O https://ftp.gnu.org/gnu/emacs/$(TARBALL); \
	tar xvfz $(TARBALL)

available-version:
	@curl --silent https://www.gnu.org/savannah-checkouts/gnu/emacs/emacs.html#Releases | pandoc -f html -t markdown | grep -E "^## Emacs [[:digit:].]+" | sed -E 's/(^## Emacs | .*)//g' | head -1

