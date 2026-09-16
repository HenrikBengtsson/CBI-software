setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}


## -----------------------------------------------------------------
## unixODBC half -- the tools
## -----------------------------------------------------------------
@test "odbc_config is installed and reports this version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run odbc_config --version
    assert_success
    assert_output --partial "${MODULE_VERSION}"
}

@test "odbc_config on PATH is the one from THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run command -v odbc_config
    assert_success
    assert_output "${PREFIX:?}/bin/odbc_config"
}

## The R package 'odbc' probes for 'odbc_config' BEFORE it tries pkg-config and
## builds against whatever '--cflags'/'--libs' report.  Those values are
## compiled in at configure time, so a build that took its prefix from
## anywhere else yields a package linked against the wrong tree while every
## other test here still passes.  Same failure shape as libhiredis's *.pc.
@test "odbc_config reports THIS module, not /usr or /usr/local" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    run odbc_config --prefix
    assert_success
    assert_output "${PREFIX:?}"

    run odbc_config --cflags
    assert_success
    assert_output --partial "-I${PREFIX}/include"

    run odbc_config --libs
    assert_success
    assert_output --partial "-L${PREFIX}/lib"
    assert_output --partial "-lodbc"
}

@test "the driver manager tools are installed" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    for exe in isql iusql odbcinst dltest; do
        run command -v "${exe}"
        assert_success
        assert_output "${PREFIX:?}/bin/${exe}"
    done
}

## --sysconfdir=/etc is deliberate: the autotools default of $PREFIX/etc would
## bake a path under PREFIX into libodbcinst (which the generic
## 'No absolute paths' check rejects) and point at a write-protected directory
## no user could ever register a driver in.  'odbcinst -j' prints the
## compiled-in locations, so it is the direct test of that choice.
@test "unixODBC reads its configuration from /etc, not from PREFIX" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run odbcinst -j
    assert_success
    assert_output --partial "/etc/odbcinst.ini"
    refute_output --partial "${PREFIX:?}/etc"
}


## -----------------------------------------------------------------
## unixODBC-devel half
## -----------------------------------------------------------------
@test "shared libraries are installed" {
    run stat "${PREFIX:?}/lib/libodbc.so"
    assert_success
    run stat "${PREFIX:?}/lib/libodbcinst.so"
    assert_success
}

@test "headers are installed" {
    for h in sql.h sqlext.h sqltypes.h odbcinst.h; do
        run stat "${PREFIX:?}/include/${h}"
        assert_success
    done
}

@test "pkg-config resolves odbc to THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists odbc
    assert_success
    prefix=$(pkg-config --variable=prefix odbc)
    assert_equal "${prefix}" "${PREFIX}"
}

@test "pkg-config resolves the full flag set" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --print-errors --cflags --libs odbc
    assert_success
    assert_output --partial "-lodbc"
}

## Deleted in post_install: they carry absolute libdir= and dependency_libs=
## paths and nothing that finds this module through pkg-config or odbc_config
## needs them.
@test "no libtool archives are left behind" {
    run bash -c "find '${PREFIX:?}/lib' -name '*.la' | wc -l"
    assert_success
    assert_output "0"
}


## -----------------------------------------------------------------
## Both halves together -- what an R package such as 'odbc' or 'RODBC' does:
## compile and link against the driver manager using the flags odbc_config
## hands out, then allocate an ODBC environment and enumerate drivers.
## -----------------------------------------------------------------
@test "an ODBC program compiles, links and runs" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    cat > main.c <<'EOF'
#include <stdio.h>
#include <sql.h>
#include <sqlext.h>

int main(void) {
  SQLHENV env = SQL_NULL_HENV;
  if (!SQL_SUCCEEDED(SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env))) return 1;
  if (!SQL_SUCCEEDED(SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (SQLPOINTER) SQL_OV_ODBC3, 0))) return 2;
  SQLCHAR desc[256], attrs[256];
  SQLSMALLINT dlen = 0, alen = 0;
  SQLRETURN rc = SQLDrivers(env, SQL_FETCH_FIRST, desc, sizeof(desc), &dlen,
                            attrs, sizeof(attrs), &alen);
  /* SQL_NO_DATA simply means no driver is registered, which is fine here */
  if (rc != SQL_NO_DATA && !SQL_SUCCEEDED(rc)) return 3;
  SQLFreeHandle(SQL_HANDLE_ENV, env);
  printf("odbc ok\n");
  return 0;
}
EOF

    run bash -c '${CC:-gcc} -o smoke main.c $(odbc_config --cflags) $(odbc_config --libs)'
    assert_success

    run ./smoke
    assert_success
    assert_output "odbc ok"
}
