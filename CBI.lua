help("Module Repository by Computational Biology and Informatics (CBI)")

local name = myModuleName()

whatis("Keywords: UCSF, CBI")
whatis("URL: http://cbi.ucsf.edu/")
whatis("Description: Repository of modules shared by Computational Biology and Informatics (http://cbi.ucsf.edu/). When loading this module, you will get access to a large number of software modules.  When unloading the module, any software modules from this " .. name .. " repository still loaded when you unload this repository module, will remain in your list of loaded modules but will be inactivate (i.e. behave as they never were loaded) until you reload this repository module again.  Example: `module load " .. name .. "` and then `module avail`.")

name = string.lower(name)
prepend_path("MODULEPATH", pathJoin("/software", "c4", name, "modulefiles"))
setenv("SOFTWARE_ROOT_CBI", pathJoin("/software", "c4", name, "software"))

require "io"
function isdir(fn)
    return (posix.stat(fn, "type") == 'directory')
end

-- Wynton, C4, or TIPCC?
local cbi_software_home="UNKNOWN"
local cbi_modules_home="UNKNOWN"

if isdir("/wynton/home/cbi/shared/software/CBI") then
   -- Wynton
   cbi_software_home = "/wynton/home/cbi/shared/software/CBI"
   cbi_modules_home  = "/wynton/home/cbi/shared/modulefiles/CBI"
elseif isdir("/software/c4/cbi/software/") then
   cbi_software_home = "/software/c4/cbi/software"
   cbi_modules_home  = "/software/c4/cbi/modulefiles"
elseif isdir("/home/shared/cbc/software_cbc/shared/apps/manual") then
   -- TIPCC (legacy)
   cbi_software_home = "/home/shared/cbc/software_cbc/shared/apps/manual"
   cbi_modules_home  = "/home/shared/cbc/software_cbc/shared/apps/modulefiles/CBI"
else
   error("Unknown file system")
end

setenv("SOFTWARE_ROOT_CBI", cbi_software_home)
setenv("MODULE_ROOT_CBI", cbi_modules_home)
prepend_path("MODULEPATH", cbi_modules_home)
