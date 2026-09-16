## Important
export LD_RUN_PATH=

include config.mk
include ../utils.mk

DOWNLOAD_URL=https://poppler.freedesktop.org
## Poppler ships .tar.xz, not the .tar.gz that utils.mk assumes
TARBALL=$(NAME)-$(VERSION).tar.xz

## FIXME
POPPLER_DATADIR=/usr/share/poppler

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xf $(TARBALL)


## NOTE: pkg-config needs the spaces in "freetype2 >= 2.10"
REQUIRED_PC_MODULES=freetype2:2.10 fontconfig:2.13 zlib: libjpeg: libpng: libtiff-4:4.1
pre_config:
	module --force purge; \
	module load $(CONFIG_MODULES); \
	missing=; \
	for spec in $(REQUIRED_PC_MODULES); do \
	    pc="$${spec%%:*}"; \
	    min="$${spec#*:}"; \
	    if [[ -n "$${min}" ]]; then query="$${pc} >= $${min}"; else query="$${pc}"; fi; \
	    if pkg-config --exists "$${query}"; then continue; fi; \
	    if pkg-config --exists "$${pc}"; then \
	        >&2 echo "ERROR: $${pc}: need >= $${min}, found $$(pkg-config --modversion "$${pc}")"; \
	    else \
	        >&2 echo "ERROR: $${pc}: not found"; \
	    fi; \
	    missing="$${missing} $${pc}"; \
	done; \
	if [[ -n "$${missing}" ]]; then \
	    >&2 echo "ERROR: Unsatisfied build dependencies:$${missing}"; \
	    >&2 echo "ERROR: If one is merely absent, install the development headers (rpm: freetype-devel fontconfig-devel zlib-devel libjpeg-turbo-devel libpng-devel libtiff-devel). If one is present but too old, see the version table in config.mk before bumping VERSION"; \
	    exit 1; \
	fi; \
	echo "All build dependencies satisfied: $(REQUIRED_PC_MODULES)"
	@if [[ -d "$(POPPLER_DATADIR)" ]]; then \
	    echo "Encoding tables found: $(POPPLER_DATADIR)"; \
	else \
	    echo "NOTE: No encoding tables at $(POPPLER_DATADIR) - CJK and Cyrillic PDFs will not extract correctly. Install the 'poppler-data' rpm to fix."; \
	fi

## -DCMAKE_INSTALL_LIBDIR=lib overrides GNUInstallDirs, which would otherwise
## pick lib64 on x86_64 and leave module.lua.tmpl guessing.
##
## -DPOPPLER_DATADIR is compiled into libpoppler as a string literal; there is
## no environment-variable override for it in GlobalParams.cc.  Because it
## points outside PREFIX (see above), the generic 'No absolute paths' check in
## '../.incl/tests/' stays clean.
$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	make --quiet pre_config
	mkdir -p $(BUILD_PATH)/build
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	cmake .. \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_SKIP_INSTALL_RPATH=ON \
	  -DPOPPLER_DATADIR="$(POPPLER_DATADIR)" \
	  -DBUILD_SHARED_LIBS=ON \
	  -DENABLE_CPP=ON \
	  -DENABLE_UTILS=ON \
	  -DENABLE_DCTDECODER=libjpeg \
	  -DENABLE_LIBTIFF=ON \
	  -DENABLE_BOOST=OFF \
	  -DENABLE_LCMS=OFF \
	  -DENABLE_LIBOPENJPEG=none \
	  -DENABLE_LIBCURL=OFF \
	  -DENABLE_NSS3=OFF \
	  -DENABLE_GPGME=OFF \
	  -DENABLE_GLIB=OFF \
	  -DENABLE_GOBJECT_INTROSPECTION=OFF \
	  -DENABLE_GTK_DOC=OFF \
	  -DENABLE_QT5=OFF \
	  -DENABLE_QT6=OFF \
	  -DBUILD_GTK_TESTS=OFF \
	  -DBUILD_QT5_TESTS=OFF \
	  -DBUILD_QT6_TESTS=OFF \
	  -DBUILD_CPP_TESTS=OFF \
	  -DBUILD_MANUAL_TESTS=OFF

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(INSTALL_MODULES); \
	cmake --build . --target install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

## The latest upstream release, which is deliberately NOT what VERSION is
## pinned to; see the version table in config.mk.
available-version:
	@curl --silent $(DOWNLOAD_URL)/ | grep -o -E "$(NAME)-[0-9]+[.][0-9]+[.][0-9]+[.]tar[.]xz" | sort -u | tail -1 | sed -E 's/^$(NAME)-(.*)[.]tar[.]xz$$/\1/'
