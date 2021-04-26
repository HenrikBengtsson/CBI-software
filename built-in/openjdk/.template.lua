help([[
openjdk-runtime: Open Java Development Kit
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: programming, java")
whatis("URL: https://openjdk.java.net/")
whatis("Description: OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition. It is the result of an effort Sun Microsystems began in 2006. Examples: `java -version` and `javac -version`.")

local main_version = string.match(version, "%d+")
if main_version == "1" then
  -- Java 1.6.x, 1.7.x 1.8.x, ..., 11, 12, ...
  main_version = string.match(version, "%d+%.%d%.%d")
end

local root = "/usr/lib/jvm"
local arch = "el7_9.x86_64"
local home = pathJoin(root, "java" .. "-" .. main_version .. "-" .. name .. "-" .. version .. "." .. arch)

setenv("JAVA_HOME", home)
prepend_path("PATH", pathJoin(home, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(home, "lib"))
prepend_path("CPATH", pathJoin(home, "include"))
