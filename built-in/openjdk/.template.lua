help([[
openjdk: Open Java Development Kit
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: programming, java")
whatis("URL: https://openjdk.java.net/")
whatis("Description: OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition. It is the result of an effort Sun Microsystems began in 2006. Examples: `java -version` and `javac -version`.")

local root = "/usr/lib/jvm"
local home = pathJoin(root, "java" .. "-" .. version)

setenv("JAVA_HOME", home)
prepend_path("PATH", pathJoin(home, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(home, "lib"))
prepend_path("CPATH", pathJoin(home, "include"))
