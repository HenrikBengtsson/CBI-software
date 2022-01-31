help([[
SCL Developer Toolset: GNU Compiler Collection, GNU Debugger, etc.
]])

local name = myModuleName()
local version = myModuleVersion()
local scl_name = "devtoolset" .. "-" .. version

whatis("Version: " .. version)
whatis("Keywords: programming, gcc")
whatis("URL: https://access.redhat.com/documentation/en-us/red_hat_developer_toolset/" .. version)
whatis("Description: These Developer Toolset provides modern versions of the GNU Compiler Collection, GNU Debugger, and other development, debugging, and performance monitoring tools. Loading these modules enables the corresponding CentOS Software Collection (SCL) `devtoolset-<version>` in the current environment.  This is an alternative to calling `source scl_source enable devtoolset-<version>`, which is an approach that is not officially supported by RedHat/CentOS.  Example: `gcc --version`.  Warning: Older versions may be removed in the future.")


require "posix"
function isdir(fn)
  return (posix.stat(fn, "type") == "directory")
end

local home = pathJoin("/opt", "rh", scl_name)

if not isdir(home) then
  LmodError("Module '" .. myModuleFullName() .. "' is not supported because this host '" .. os.getenv("HOSTNAME") .. "' does not have path '" .. home .. "'")
end


-- Don't edit! Created using: 
-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /opt/rh/devtoolset-10/enable
prepend_path("INFOPATH","/opt/rh/devtoolset-10/root/usr/share/info")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-10/root/usr/lib/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-10/root/usr/lib64/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-10/root/usr/lib")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-10/root/usr/lib64")
prepend_path("MANPATH","/opt/rh/devtoolset-10/root/usr/share/man")
prepend_path("PATH","/opt/rh/devtoolset-10/root/usr/bin")
setenv("PCP_DIR","/opt/rh/devtoolset-10/root")
prepend_path("PKG_CONFIG_PATH","/opt/rh/devtoolset-10/root/usr/lib64/pkgconfig")
