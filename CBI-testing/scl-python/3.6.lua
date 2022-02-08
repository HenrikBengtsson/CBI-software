help([[
SCL Python: Python with Additional Utilities via CentOS Software Collections [DEPRECATED]
]])

local name = myModuleName()
local version = myModuleVersion()
local version_sans_period = string.gsub(version, "%.", "")
local scl_name = "rh-python" .. version_sans_period
if version == "3.3" then
  scl_name = "python" .. version_sans_period
end  

whatis("Version: " .. version)
whatis("Keywords: programming, Python")
whatis("URL: https://www.softwarecollections.org/en/scls/rhscl/" .. scl_name .. "/")
whatis("Description: Enables the CentOS Software Collection (SCL) `" .. scl_name .. "` in the current environment.  This is an alternative to calling `source scl_source enable " .. scl_name .. "`, which is not officially supported by RedHat/CentOS.  Example: `python --version` and `pip --version`.  Warning: This module is DEPRECATED and should no longer be used because Python SCLs are deprecated, which in turn is because Python 3 is now available directly by CentOS.")

local home = "/opt/rh/rh-python" .. version_sans_period

if not isDir(home) then
  LmodError("Module '" .. myModuleFullName() .. "' is not supported because this host '" .. os.getenv("HOSTNAME") ..
 "' does not have path '" .. home .. "'")
end


local path = dirname(myFileName())
local pathname = pathJoin(path, ".incl", version_sans_period .. ".lua")
loadfile(pathname)()
