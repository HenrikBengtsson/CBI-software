help("Module Repository by Computational Biology and Informatics (CBI)")

local name = myModuleName()

whatis("Keywords: UCSF, CBI")
whatis("URL: https://cbi.ucsf.edu/")
whatis("Description: Repository of modules shared by Computational Biology and Informatics (http://cbi.ucsf.edu/). When loading this module, you will get access to a large number of software modules.  When unloading the module, any software modules from this " .. name .. " repository still loaded when you unload this repository module, will remain in your list of loaded modules but will be inactivate (i.e. behave as they never were loaded) until you reload this repository module again.  Example: `module load " .. name .. "` and then `module avail`.")

require "io"
local function isdir(fn)
    return (posix.stat(fn, "type") == 'directory')
end

local function isempty(s)
    return s == nil or s == ""
end

local software_root = nil
local modules_root = nil

-- Set default values conditioned on underlying system
if isdir("/wynton/home/cbi/shared/software/CBI") then
   -- Wynton (https://wynton.ucsf.edu/)
   software_root = "/wynton/home/cbi/shared/software/CBI"
   modules_root  = "/wynton/home/cbi/shared/modulefiles/CBI"
elseif isdir("/software/c4/cbi/software/") then
   -- C4 (https://www.c4.ucsf.edu/)
   software_root = "/software/c4/cbi/software"
   modules_root  = "/software/c4/cbi/modulefiles"
elseif isdir("/home/shared/cbc/software_cbc/shared/apps/manual") then
   -- TIPCC (legacy)
   software_root = "/home/shared/cbc/software_cbc/shared/apps/manual"
   modules_root  = "/home/shared/cbc/software_cbc/shared/apps/modulefiles/CBI"
end

software_root = os.getenv("SOFTWARE_ROOT_CBI", software_root)
modules_root = os.getenv("MODULE_ROOT_CBI", modules_root)

if isempty(software_root) then
   LmodError("Failed to infer 'SOFTWARE_ROOT_CBI' from the file system. Please set manually")
end

if isempty(modules_root) then
   LmodError("Failed to infer 'MODULES_ROOT_CBI' from the file system. Please set manually")
end

setenv("SOFTWARE_ROOT_CBI", software_root)
setenv("MODULE_ROOT_CBI", modules_root)

prepend_path("MODULEPATH", modules_root)
