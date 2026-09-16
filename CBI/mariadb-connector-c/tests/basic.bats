setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


## -----------------------------------------------------------------
## 'mariadb_config' -- what RMariaDB and RMySQL call at build time
## -----------------------------------------------------------------

## Deliberately '--cc_version' and not '--version'.  The latter reports
## the MariaDB *server* version this connector emulates (10.8.8 for the
## 3.4.x series), which has nothing to do with MODULE_VERSION.
@test "mariadb_config is installed and reports this version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run mariadb_config --cc_version
    assert_success
    assert_output "${MODULE_VERSION}"
}

@test "mariadb_config on PATH is the one from THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run command -v mariadb_config
    assert_success
    assert_output "${PREFIX:?}/bin/mariadb_config"
}

## Both packages compile against whatever '--cflags'/'--libs' report and
## those values are baked into the built package, so a build that took its
## prefix from somewhere else yields a package linked against the wrong
## tree while every other test here still passes.  Same failure shape as
## unixODBC's 'odbc_config'.
@test "mariadb_config reports THIS module, not /usr or /usr/local" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    run mariadb_config --variable=pkglibdir
    assert_success
    assert_output "${PREFIX:?}/lib"

    run mariadb_config --cflags
    assert_success
    assert_output --partial "-I${PREFIX}/include/mariadb"

    run mariadb_config --libs
    assert_success
    assert_output --partial "-L${PREFIX}/lib"
    assert_output --partial "-lmariadb"
}

## RMariaDB's configure prefers 'mysql_config' over 'mariadb_config' and
## only falls back to the latter when the former is absent.  Connector/C
## installs 'mariadb_config' alone, so post_install adds this one; drop it
## and RMariaDB silently builds against a system MySQL client library if
## the host happens to have one.
@test "mysql_config gives the same answers as mariadb_config" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    run command -v mysql_config
    assert_success
    assert_output "${PREFIX:?}/bin/mysql_config"

    run bash -c 'test "$(mysql_config --libs)" = "$(mariadb_config --libs)"'
    assert_success

    run bash -c 'test "$(mysql_config --cflags)" = "$(mariadb_config --cflags)"'
    assert_success
}

## 'mariadb_config' prints paths derived from its own location; pre_config
## drops the compiled-in prefix it otherwise falls back to.  It is the only
## executable this module installs, so this is what the generic
## 'No absolute paths' check comes down to.
@test "mariadb_config carries no compiled-in absolute paths" {
    run grep -q -F "${PREFIX:?}" "${PREFIX}/bin/mariadb_config"
    assert_failure
}

## Both of the above together.  'mysql_config' is a wrapper rather than a
## symbolic link precisely because of this: 'mariadb_config' looks for
## "/bin/<argv[0]>" in /proc/self/exe, so under any other name it finds
## nothing and reports the prefix it was built with instead.
@test "both tools follow the tree if it is moved" {
    cp -a "${PREFIX:?}" "${BATS_TEST_TMPDIR:?}/moved"
    chmod -R u+w "${BATS_TEST_TMPDIR}/moved"

    run "${BATS_TEST_TMPDIR}/moved/bin/mariadb_config" --libs
    assert_success
    assert_output --partial "-L${BATS_TEST_TMPDIR}/moved/lib"
    refute_output --partial "${PREFIX}"

    run "${BATS_TEST_TMPDIR}/moved/bin/mysql_config" --libs
    assert_success
    assert_output --partial "-L${BATS_TEST_TMPDIR}/moved/lib"
    refute_output --partial "${PREFIX}"
}


## -----------------------------------------------------------------
## The '-devel' half -- libraries, headers, pkg-config
## -----------------------------------------------------------------
@test "shared libraries are installed" {
    for lib in libmariadb.so libmariadb.so.3; do
        run stat "${PREFIX:?}/lib/${lib}"
        assert_success
    done
}

## WITH_MYSQLCOMPAT=ON.  Software written against the MySQL client library
## links '-lmysqlclient'; that includes RMariaDB and RMySQL when neither
## config script is found and their built-in default is used.
@test "the libmysqlclient compatibility names are installed" {
    for lib in libmysqlclient.so libmysqlclient_r.so; do
        run stat "${PREFIX:?}/lib/${lib}"
        assert_success
    done
}

@test "headers are installed" {
    for h in mysql.h errmsg.h mariadb_version.h mysql/plugin_auth.h; do
        run stat "${PREFIX:?}/include/mariadb/${h}"
        assert_success
    done
}

@test "pkg-config resolves libmariadb to THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    run pkg-config --exists libmariadb
    assert_success

    prefix=$(pkg-config --variable=prefix libmariadb)
    assert_equal "${prefix}" "${PREFIX}"

    run pkg-config --modversion libmariadb
    assert_success
    assert_output "${MODULE_VERSION}"

    run pkg-config --print-errors --cflags --libs libmariadb
    assert_success
    assert_output --partial "-lmariadb"
}

## The generic RUNPATH check scans executables only, and CMake installs
## the library mode 644, so it never looks at libmariadb.so.3 -- the one
## file in this module where an inherited LD_RUN_PATH would show up.
@test "the library carries no RUNPATH" {
    run bash -c "readelf -d '${PREFIX:?}/lib/libmariadb.so.3' | grep -c RUNPATH || true"
    assert_output "0"
}

## Every client plugin is pinned to STATIC, so nothing is ever dlopen()ed
## from MARIADB_PLUGINDIR and no plugin directory is installed.  If a
## version bump reintroduces a DYNAMIC plugin, this fails and the
## authentication test below starts depending on a directory on disk.
@test "no dynamically loaded client plugins are installed" {
    run bash -c "find '${PREFIX:?}/lib' -name '*.so' -path '*plugin*' | wc -l"
    assert_success
    assert_output "0"
}


## -----------------------------------------------------------------
## Both halves together -- what RMariaDB does: compile and link against
## the client library using the flags 'mariadb_config' hands out, look up
## the authentication plugins a server will ask for, then connect.
## -----------------------------------------------------------------
@test "a client program compiles, links and runs" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    cat > main.c <<'EOF'
#include <stdio.h>
#include <mysql.h>

/* <mysql/client_plugin.h> cannot be included: it pulls in <ma_compress.h>,
   which 3.4.9 installs no copy of.  Declare the one function we call. */
struct st_mysql_client_plugin;
extern struct st_mysql_client_plugin *
mysql_client_find_plugin(MYSQL *mysql, const char *name, int type);
#define AUTH_PLUGIN 2  /* MYSQL_CLIENT_AUTHENTICATION_PLUGIN */

int main(void) {
  MYSQL *my;
  int missing = 0;
  /* MySQL 8 and MariaDB default to these; 'no_such_plugin' is the control
     that shows a lookup can fail at all */
  const char *plugins[] = {"mysql_native_password", "caching_sha2_password",
                           "sha256_password", "dialog", "client_ed25519",
                           "parsec", "mysql_clear_password", NULL};

  printf("client %s\n", mysql_get_client_info());
  if (mysql_library_init(0, NULL, NULL) != 0) return 1;
  if ((my = mysql_init(NULL)) == NULL) return 2;

  for (int i = 0; plugins[i] != NULL; i++) {
    if (mysql_client_find_plugin(my, plugins[i], AUTH_PLUGIN) == NULL) {
      printf("missing plugin %s\n", plugins[i]);
      missing++;
    }
  }
  if (mysql_client_find_plugin(my, "no_such_plugin", AUTH_PLUGIN) != NULL) {
    printf("lookup never fails\n");
    missing++;
  }
  if (missing == 0) printf("plugins ok\n");

  /* nothing listens on that port: the connection must fail, but only
     after the library has resolved the host and opened a socket */
  if (mysql_real_connect(my, "127.0.0.1", "nobody", "", NULL, 47836, NULL, 0) == NULL)
    printf("connect %u\n", mysql_errno(my));
  else
    printf("connect 0\n");

  mysql_close(my);
  mysql_library_end();
  return 0;
}
EOF

    run bash -c '${CC:-gcc} -o smoke main.c $(mariadb_config --cflags) $(mariadb_config --libs)'
    assert_success

    run ./smoke
    assert_success
    assert_output --partial "client ${MODULE_VERSION}"
    assert_output --partial "plugins ok"
    refute_output --partial "missing plugin"
    ## CR_CONN_HOST_ERROR (2003) on a refused TCP connection; some hosts
    ## report CR_CONNECTION_ERROR (2002) instead
    assert_output --regexp "connect 200[23]"
}
