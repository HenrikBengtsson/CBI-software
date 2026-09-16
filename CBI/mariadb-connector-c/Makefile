## Always clear LD_RUN_PATH.  'unexport', not 'export LD_RUN_PATH=': ld
## writes an empty DT_RUNPATH when the variable is set but empty, and the
## generic RUNPATH check rejects that too.
unexport LD_RUN_PATH

include config.mk
include ../utils.mk

DOWNLOAD_URL=https://archive.mariadb.org/connector-c-$(VERSION)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xf $(TARBALL)

## NOTE: pkg-config needs the spaces in "openssl >= 1.1"
REQUIRED_PC_MODULES=openssl:1.1 zlib:

## The sed drops 'mariadb_config's compiled-in prefix, which is what put an
## absolute path in the only executable this module installs.  It locates
## itself via /proc/self/exe and falls back to that prefix only if that
## fails, which on Linux it does not.
pre_config:
	sed -i 's|"@CMAKE_SYSROOT@@CMAKE_INSTALL_PREFIX@"|""|' $(BUILD_PATH)/mariadb_config/mariadb_config.c.in
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
	    >&2 echo "ERROR: Install the development headers (rpm: openssl-devel zlib-devel)"; \
	    exit 1; \
	fi; \
	echo "All build dependencies satisfied: $(REQUIRED_PC_MODULES)"

CMAKE_OPTS=\
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
  -DCMAKE_SKIP_INSTALL_RPATH=ON \
  -DINSTALL_LIBDIR=lib \
  -DINSTALL_INCLUDEDIR=include/mariadb \
  -DINSTALL_PCDIR=lib/pkgconfig \
  -DINSTALL_PLUGINDIR=lib/mariadb/plugin \
  -DINSTALL_MANDIR=share/man \
  -DWITH_SSL=OPENSSL \
  -DWITH_EXTERNAL_ZLIB=ON \
  -DWITH_MYSQLCOMPAT=ON \
  -DWITH_CURL=OFF \
  -DWITH_UNIT_TESTS=OFF \
  -DCLIENT_PLUGIN_DIALOG=STATIC \
  -DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC \
  -DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC \
  -DCLIENT_PLUGIN_CLIENT_ED25519=STATIC \
  -DCLIENT_PLUGIN_PARSEC=STATIC \
  -DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC \
  -DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=OFF \
  -DCLIENT_PLUGIN_ZSTD=OFF \
  -DCLIENT_PLUGIN_REMOTE_IO=OFF

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	make --quiet pre_config
	mkdir -p $(BUILD_PATH)/build
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	unset LD_RUN_PATH; \
	cmake .. $(CMAKE_OPTS)

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	unset LD_RUN_PATH; \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(INSTALL_MODULES); \
	unset LD_RUN_PATH; \
	cmake --build . --target install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

## RMariaDB and RMySQL look for 'mysql_config' before 'mariadb_config'.
## A wrapper, not a symbolic link: invoked through a link under another
## name, 'mariadb_config' fails to find itself and reports stale paths.
post_install:
	install -m 0755 mysql_config.sh $(PREFIX)/bin/mysql_config
	make --quiet write_protect_install

available-version:
	@curl --silent https://archive.mariadb.org/ | grep -o 'connector-c-[0-9][0-9.]*' | sed 's/connector-c-//' | sort -V -u | tail -1
