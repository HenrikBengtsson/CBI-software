help([[
SCL Python
]])

local name = myModuleName()
local version = myModuleVersion()
local version = "3.6"
whatis("Version: " .. version)
whatis("Keywords: programming, Python")
whatis("URL: ...")
whatis("Description: Python 3.6. Example: `python --version`.")

local path = dirname(myFileName())
local pathname = pathJoin(path, ".incl", "36.lua")
loadfile(pathname)()

