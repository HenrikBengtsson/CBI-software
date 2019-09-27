help([[
SCL Developer Toolset: GNU Compiler Collection, GNU Debugger, etc.
]])

local name = myModuleName()
local version = myModuleVersion()
local scl_name = "devtoolset" .. version

whatis("Version: " .. version)
whatis("Keywords: programming, gcc")
whatis("URL: https://www.softwarecollections.org/en/scls/rhscl/" .. scl_name .. "/")
whatis("Description: Enables the CentOS Software Collection (SCL) `" .. scl_name .. "` in the current environment.  This is an alternative to calling `source scl_source enable " .. scl_name .. "`, which is not officially supported by RedHat/CentOS.  Example: `gcc --version`.")

local path = dirname(myFileName())
local pathname = pathJoin(path, ".incl", version .. ".lua")
loadfile(pathname)()

