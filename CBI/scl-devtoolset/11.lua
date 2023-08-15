help([[
SCL Developer Toolset: GNU Compiler Collection, GNU Debugger, etc.
]])

local name = myModuleName()
local version = myModuleVersion()
local scl_name = "devtoolset" .. "-" .. version

whatis("Version: " .. version)
whatis("Keywords: programming, gcc")
whatis("URL: https://access.redhat.com/documentation/en-us/red_hat_developer_toolset/" .. version .. ", https://gcc.gnu.org/develop.html#timeline (GCC release schedule)")
whatis([[
Description: These Developer Toolset provides modern versions of the GNU Compiler Collection, GNU Debugger, and other development, debugging, and performance monitoring tools. Loading these modules enables the corresponding CentOS Software Collection (SCL) `devtoolset-<version>` in the current environment.  This is an alternative to calling `source scl_source enable devtoolset-<version>`, which is an approach that is not officially supported by RedHat/CentOS.
Examples: `gcc --version`.  Warning: Older versions may be removed in the future.
Requirement: CentOS 7.
]])

-- This module is only available on CentOS 7
if os.getenv("CBI_LINUX") ~= "centos7" then
  LmodError("Module '" .. myModuleFullName() .. "' is only available on CentOS 7 machines, but not on host '" .. os.getenv("HOSTNAME") .. "', which runs '" ..
 os.getenv("CBI_LINUX") .. "'")
end


local home = pathJoin("/opt", "rh", scl_name)

if not isDir(home) then
  LmodError("Module '" .. myModuleFullName() .. "' is not supported because this host '" .. os.getenv("HOSTNAME") .. "' does not have path '" .. home .. "'")
end


-- Don't edit! Created using: 
-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /opt/rh/devtoolset-11/enable
setenv("INFOPATH","/opt/rh/devtoolset-11/root/usr/share/info")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-11/root/usr/lib64/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-11/root/usr/lib")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-11/root/usr/lib64")
prepend_path("MANPATH","/opt/rh/devtoolset-11/root/usr/share/man")
prepend_path("PATH","/opt/rh/devtoolset-11/root/usr/bin")
setenv("PCP_DIR","/opt/rh/devtoolset-11/root")
setenv("PKG_CONFIG_PATH","/opt/rh/devtoolset-11/root/usr/lib64/pkgconfig")
