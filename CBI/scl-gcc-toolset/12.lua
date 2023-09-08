help([[
SCL GCC Toolset: GNU Compiler Collection, GNU Debugger, etc.
]])

local name = myModuleName()
local version = myModuleVersion()
local scl_name = "gcc-toolset" .. "-" .. version

whatis("Version: " .. version)
whatis("Keywords: programming, gcc")
whatis("URL: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/developing_c_and_cpp_applications_in_rhel_8/additional-toolsets-for-development_developing-applications#gcc-toolset_assembly_additional-toolsets-for-development, https://gcc.gnu.org/develop.html#timeline (GCC release schedule)")
whatis([[
Description: These Developer Toolset provides modern versions of the GNU Compiler Collection, GNU Debugger, and other development, debugging, and performance monitoring tools. Loading these modules enables the corresponding RedHat Software Collection (SCL) `gcc-toolset-<version>` in the current environment.  This is an alternative to calling `source scl_source enable gcc-toolset-<version>`, which is an approach that is not officially supported by RedHat.
Examples: `gcc --version`.  Warning: Older versions may be removed in the future.
Requirement: Rocky 8.
]])

-- This module is only available on Rocky 8
if os.getenv("CBI_LINUX") ~= "rocky8" then
  LmodError("Module '" .. myModuleFullName() .. "' is only available on Rocky 8 machines, but not on host '" .. os.getenv("HOSTNAME") .. "', which runs '" .. os.getenv("CBI_LINUX") .. "'")
end


local home = pathJoin("/opt", "rh", scl_name)

if not isDir(home) then
  LmodError("Module '" .. myModuleFullName() .. "' is not supported because this host '" .. os.getenv("HOSTNAME") .. "' does not have path '" .. home .. "'")
end


-- Don't edit! Created using: 
-- /usr/share/lmod/lmod/libexec/sh_to_modulefile /opt/rh/gcc-toolset-12/enable
setenv("INFOPATH","/opt/rh/gcc-toolset-12/root/usr/share/info")
prepend_path("LD_LIBRARY_PATH","/opt/rh/gcc-toolset-12/root/usr/lib64")
prepend_path("MANPATH","/opt/rh/gcc-toolset-12/root/usr/share/man")
prepend_path("PATH","/opt/rh/gcc-toolset-12/root/usr/bin")
setenv("PCP_DIR","/opt/rh/gcc-toolset-12/root")
setenv("PKG_CONFIG_PATH","/opt/rh/gcc-toolset-12/root/usr/lib64/pkgconfig")
