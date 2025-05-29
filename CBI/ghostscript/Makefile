include config.mk
include ../utils.mk


VERSION_FLAT=10050
GITHUB_REPO=https://github.com/ArtifexSoftware/ghostpdl-downloads
TARBALL=ghostscript-$(VERSION).tar.xz

LDFLAGS += -lstdc++fs
LDLIBS += -lstdc++fs

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/gs$(VERSION_FLAT)/$(TARBALL); \
	tar xf "$(TARBALL)"

available-version:
	@curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^ghostpdl-" | sed -E 's/^ghostpdl-//' | grep -E "^[[:digit:].]+$$" | sort -r -h | head -n 1
