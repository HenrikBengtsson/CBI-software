include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://mirror.ibcp.fr/pub/gnu/$(NAME)/$(TARBALL); \
	tar xvfz $(TARBALL)

available-version:
	curl --silent https://git.savannah.gnu.org/cgit/gsl.git/tree/NEWS | grep -F "What is new in gsl-" | sed -E 's/.* What is new in gsl-([[:digit:].]+).*/\1/'
