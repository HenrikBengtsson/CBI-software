include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz
GITHUB_REPO=https://github.com/redis/hiredis

## hiredis.pc is generated during the BUILD (it is part of the default 'all'
## target) and bakes in prefix=, libdir= and includedir= from PREFIX, which
## defaults to /usr/local.  Passing PREFIX only to 'make install' therefore
## ships a hiredis.pc pointing at /usr/local, and consumers such as the R
## package 'redux' resolve to the wrong tree.  The same variables are passed
## to the build, and for the same reason they are given on the command line
## rather than the environment (LIBRARY_PATH is a compiler variable our own
## modules set; see the install target below).
BUILD_OPTS=PREFIX=$(PREFIX) LIBRARY_PATH=lib INCLUDE_PATH=include/hiredis PKGCONF_PATH=pkgconfig

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar xf $(TARBALL)

## hiredis takes its install prefix from a PREFIX variable given on the
## 'make install' command line; the generic rule in ../utils.mk does not pass
## one, so the install step is overridden here.  Otherwise identical to it.
##
## LIBRARY_PATH, INCLUDE_PATH and PKGCONF_PATH must be passed explicitly too.
## hiredis declares them with '?=' and builds its install paths as
## $(PREFIX)/$(LIBRARY_PATH) etc., but LIBRARY_PATH is also a standard compiler
## environment variable that our own library modules set -- so a loaded module
## silently turns the install path into $(PREFIX)/<absolute path>, and the
## library lands in $(PREFIX)/home/hb/... instead of $(PREFIX)/lib.  Assigning
## them on the command line overrides both the '?=' default and the environment.
$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(PREFIX)
	module --force purge; \
	module try-load $(INSTALL_MODULES); \
	cd $(BUILD_PATH); \
	make --quiet PREFIX="$(PREFIX)" LIBRARY_PATH=lib INCLUDE_PATH=include/hiredis PKGCONF_PATH=pkgconfig install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://api.github.com/repos/redis/hiredis/releases/latest | jq -r .tag_name | sed 's/^v//'
