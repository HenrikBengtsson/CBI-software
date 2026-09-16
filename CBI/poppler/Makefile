include config.mk
include ../utils.mk

DOWNLOAD_URL=https://poppler.freedesktop.org
## Poppler ships .tar.xz, not the .tar.gz that utils.mk assumes
TARBALL=$(NAME)-$(VERSION).tar.xz

## Where libpoppler looks for the CJK/Cyrillic encoding tables (cMaps,
## cidToUnicode, nameToUnicode, unicodeMap) at run time.  Those tables are a
## separate upstream tarball under a separate license -- what distributions
## ship as 'poppler-data' -- and this module deliberately does NOT bundle
## them.  Instead it points at the distribution's copy, which is exactly what
## Red Hat's own poppler build does.
##
## They are optional: poppler reads them if they are present and degrades
## quietly if they are not.  Nothing here breaks without them; text
## extraction from CJK and Cyrillic PDFs just comes out wrong.  If that turns
## out to matter on this cluster, the fix is the 'poppler-data' rpm (an admin
## ask; it is in AppStream) rather than vendoring the tarball into PREFIX.
##
## Setting this explicitly rather than letting poppler's CMake auto-detect
## 'poppler-data.pc' keeps the build deterministic, and keeps the installed
## libraries free of any path under PREFIX -- see the note on the generic
## 'No absolute paths' check below.
POPPLER_DATADIR=/usr/share/poppler

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xf $(TARBALL)


## Poppler's CMake quietly drops any backend whose development headers are
## missing.  Worse, the ones we do want end up in poppler.pc's
## 'Requires.private:', and pkg-config resolves that whole chain or nothing,
## so a consumer -- say, the 'pdftools' R package running
## `pkg-config --cflags --libs poppler-cpp` -- fails outright if any of these
## *.pc files is absent.  Fail here rather than after a full C++23 build.
REQUIRED_PC_MODULES=freetype2 fontconfig zlib libjpeg libpng libtiff-4
pre_config:
	module --force purge; \
	module load $(CONFIG_MODULES); \
	missing=; \
	for pc in $(REQUIRED_PC_MODULES); do \
	    if ! pkg-config --exists "$${pc}"; then \
	        missing="$${missing} $${pc}"; \
	    fi; \
	done; \
	if [[ -n "$${missing}" ]]; then \
	    >&2 echo "ERROR: Missing pkg-config module(s):$${missing}"; \
	    >&2 echo "ERROR: Install the matching development headers (rpm: freetype-devel fontconfig-devel zlib-devel libjpeg-turbo-devel libpng-devel libtiff-devel; deb: libfreetype-dev libfontconfig-dev zlib1g-dev libjpeg-dev libpng-dev libtiff-dev) and re-run 'make config'"; \
	    exit 1; \
	fi; \
	echo "All required pkg-config modules present: $(REQUIRED_PC_MODULES)"
	@if [[ -d "$(POPPLER_DATADIR)" ]]; then \
	    echo "Encoding tables found: $(POPPLER_DATADIR)"; \
	else \
	    echo "NOTE: No encoding tables at $(POPPLER_DATADIR) - CJK and Cyrillic PDFs will not extract correctly. Install the 'poppler-data' rpm to fix."; \
	fi

## What we are after here is the equivalent of the distributions'
## 'poppler-cpp-devel': libpoppler-cpp plus its headers and *.pc file, which
## is what R packages such as 'pdftools' link against.  ENABLE_UTILS gives us
## 'pdftotext' and friends for free on top of that.
##
## Everything else is turned off on purpose.  Rocky/RHEL 9 puts harfbuzz-devel,
## lcms2-devel and openjpeg2-devel in the CodeReady Builder repository, which
## is not enabled on this cluster, and ships boost 1.75 where poppler wants
## >= 1.83; each of those is a hard 'FATAL_ERROR' in poppler's CMake unless
## explicitly disabled.  Qt and GLib are irrelevant for a headless cluster.
## Cairo is left to auto-detection: it is genuinely optional and only decides
## whether 'pdftocairo' is built.
##
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
	  -DENABLE_LIBJPEG=ON \
	  -DENABLE_LIBTIFF=ON \
	  -DENABLE_BOOST=OFF \
	  -DENABLE_HARFBUZZ=OFF \
	  -DENABLE_LCMS=OFF \
	  -DENABLE_LIBOPENJPEG=OFF \
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

available-version:
	@curl --silent $(DOWNLOAD_URL)/ | grep -o -E "$(NAME)-[0-9]+[.][0-9]+[.][0-9]+[.]tar[.]xz" | sort -u | tail -1 | sed -E 's/^$(NAME)-(.*)[.]tar[.]xz$$/\1/'
