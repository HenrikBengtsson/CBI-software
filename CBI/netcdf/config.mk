NAME=netcdf
VERSION=4.10.1
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=nc-config
INSTALL_TARGET_FILE=bin/nc-config

CONFIG_MODULES=CBI scl-gcc-toolset hdf5

# --disable-dap avoids requiring curl-devel if not strictly needed, 
# but usually system curl is fine. We will stick to defaults.
# CONFIG_OPTS=

DEPENDS_ON=hdf5
