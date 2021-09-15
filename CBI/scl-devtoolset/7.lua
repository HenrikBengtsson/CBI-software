help([[
SCL Developer Toolset: GNU Compiler Collection, GNU Debugger, etc.
]])

local name = myModuleName()
local version = myModuleVersion()
local scl_name = "devtoolset" .. "-" .. version

whatis("Version: " .. version)
whatis("Keywords: programming, gcc")
whatis("URL: https://www.softwarecollections.org/en/scls/rhscl/" .. scl_name .. "/")
whatis("Description: Enables the CentOS Software Collection (SCL) `" .. scl_name .. "` in the current environment.  This is an alternative to calling `source scl_source enable " .. scl_name .. "`, which is an approach that is not officially supported by RedHat/CentOS.  Example: `gcc --version`.")


require "posix"
function isdir(fn)
  return (posix.stat(fn, "type") == "directory")
end

local home = "/opt/rh/devtoolset-7"

if not isdir(home) then
  LmodError("Module '" .. myModuleFullName() .. "' is not supported because this host '" .. os.getenv("HOSTNAME") .. "' does not have path '" .. home .. "'")
end


-- Don't edit! Created using: 
-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /opt/rh/devtoolset-7/enable
setenv("INFOPATH","/opt/rh/devtoolset-7/root/usr/share/info")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-7/root/usr/lib/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-7/root/usr/lib64/dyninst")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-7/root/usr/lib")
prepend_path("LD_LIBRARY_PATH","/opt/rh/devtoolset-7/root/usr/lib64")
prepend_path("MANPATH","/opt/rh/devtoolset-7/root/usr/share/man")
prepend_path("PATH","/opt/rh/devtoolset-7/root/usr/bin")
setenv("PCP_DIR","/opt/rh/devtoolset-7/root")
setenv("PERL5LIB","/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/vendor_perl")
prepend_path("PYTHONPATH","/opt/rh/devtoolset-7/root/usr/lib/python2.7/site-packages")
prepend_path("PYTHONPATH","/opt/rh/devtoolset-7/root/usr/lib64/python2.7/site-packages")
