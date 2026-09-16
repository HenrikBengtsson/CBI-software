include config.mk

TARBALL=$(NAME)-$(VERSION).tar.gz
URL=https://ftp.postgresql.org/pub/source/v$(VERSION)/$(TARBALL)

include ../utils.mk

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar xfz $(TARBALL)

post_config:
	sed -i 's|^rpath = .*|rpath =|g' $(BUILD_PATH)/src/Makefile.port || true
	echo -e "all:\n\tmake -C src/backend generated-headers\n\tmake -C src/interfaces/libpq all\n\tmake -C src/bin/psql all\n\tmake -C src/bin/pg_config all\n\ninstall:\n\tmake -C src/interfaces/libpq install\n\tmake -C src/bin/psql install\n\tmake -C src/bin/pg_config install\n\tmake -C src/include install" > $(BUILD_PATH)/GNUmakefile

post_install:
	mkdir -p $(PREFIX)/share/man

available-version:
	@curl --silent https://ftp.postgresql.org/pub/source/ | grep -o 'href="v[0-9.]*/"' | grep -v beta | grep -v rc | sed 's/href="v//; s/\/"//' | sort -V | tail -n 1
