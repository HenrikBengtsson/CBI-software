message(sprintf("Start time: %s", Sys.time()))

if (utils::file_test("-f", ".lock")) stop("There is already another process running")
file.create(".lock")

t0 <- Sys.time()
message(sprintf("Current time: %s", t0))

if (!requireNamespace("parallelly", quietly = TRUE)) install.packages("parallelly")

options(Ncpus = parallelly::availableCores())
message(sprintf("Number of parallel installs: %d", getOption("Ncpus")))

repos <- getOption("repos")
message(sprintf("R package repositories: [n=%d] %s", length(repos), paste(names(repos), sQuote(repos), sep = "=", collapse = ", ")))

db <- utils::available.packages()
pkgs <- unclass(db[, "Package"])
message(sprintf("Number of available packages: %d", length(pkgs)))

db <- utils::installed.packages()
skip <- pkgs_done <- unclass(db[, "Package"])
message(sprintf("Number of installed packages: %d", length(pkgs_done)))
pkgs <- setdiff(pkgs, skip)

# -------------------------------------------------------------------------------------
# Packages requiring dependencies not available on C4/Wynton
# -------------------------------------------------------------------------------------
`%hence%` <- function(lhs, rhs) c(lhs, rhs)

pkgs_excl <- c(
  ## Gets stuck in an endless "tcltk2" loop if X11 is not available, cf. strace -p <PID>
  "biplotbootGUI",
  "cncaGUI",
  "multibiplotGUI",
  
  ## Packages that require CPLEX (https://www.ibm.com/products/ilog-cplex-optimization-studio)
  "Rcplex" %hence% c("ROI.plugin.cplex", "otinference", "CVXR", "designmatch", "relations", "sbw"),  ## configure: error: CPLEX include directory ./include does not exist

  ## Packages that require OpenCL (https://www.khronos.org/opencl/)
  "gpuMagic",
  "OpenCL",

  ## Packages that require JAGS, i.e. 'module load CBI jags'
  # "rjags" %hence% c("pexm"),

  ## Packages requiring 'MeCab' library
  "RcppMeCab", ## Error: package or namespace load failed for ‘RcppMeCab’ in dyn.load(file, DLLpath = DLLpath, ...): ... undefined symbol: mecab_model_new_tagger
  "RmecabKo",  ## nouns.cpp:10:10: fatal error: mecab.h: No such file or directory

  ## Packages that require .NET framework
  "rawrr" %hence% c("MsBackendRawFileReader"), ##  The cross platform, open source .NET framework (mono) is not available. Consider to install 'apt-get install mono-runtime' on Linux

  ## Packages that require the GLPK library
  "Rglpk" %hence% c("cosso", "designmatch", "FRAPO", "LPmerge", "optrefine", "stratbr", "TukeyRegion", "Bergm", "ConcordanceTest", "eatATA", "ffsimulator", "fPortfolio", "gemtc", "hdme", "HyRiM", "ITRSelect", "kantorovich", "lpda", "MCDA", "MSCMT", "MultAlloc", "multinomineq", "natstrat", "npbr", "otinference", "parma", "ROI.models.miplib", "ROI.plugin.glpk", "sdcTable", "strand", "StratifiedSampling", "visaOTR"),
  
  ## Packages that require OCI libraries
  "ROracle" %hence% c("ora"), ## OCI libraries not found

  ## Packages that require OpenBabel (https://openbabel.org/)
  "ChemmineOB" %hence% c("RMassBank"),  ## Requires <openbabel/obutil.h>

  ## Packages requiring 'OpenBUGS' library (https://openbugs.net)
  ## OpenBUGS is a 32-bit library and requires special build tools
  "BRugs" %hence% c("bcrm", "dclone", "miscF", "R2WinBUGS"),
    "dclone" %hence% c("dcmle", "PVAClone", "sharx", "ordinalbayes"),
    "miscF" %hence% c("agRee", "PottsUtils"),

  ## Packages requiring 'Poppler Glib interface' (poppler-glib-devel)
  "Rpoppler",

  # Packages that requires 'QuantLib' library (https://www.quantlib.org/)
  "RQuantLib" %hence% c("bizdays", "rtsdata"),

  ## Packages requiring 'rrdtool-devel' (installed on C4 but not Wynton)
  # "rrd", ## rrdtool-devel (Fedora, CentOS, RHEL)

  ## Packages that require 'SYMPHONY' library
  "Rsymphony" %hence% c("PortfolioOptim", "prioriactions", "ROI.plugin.symphony"),

  ## Packages requiring Tcl version 8.6
  "loon" %hence% c("loon.ggplot", "loon.shiny", "loon.tourr", "rfviz", "zenplots", "diveR"),
  "switchboard", ## error: [tcl] invalid command name "ttk::style"

  # Packages that require special libraries or dependencies
  "cncaGUI",  ## requires 'Tcl/Tk package BWidget'

  # Packages requiring gmp or mpfr
  "AlphaHull3D",
  "Boov",
  "cgalMeshes",
  "cgalPolygons",
  "delaunay",
  "interpolation",
  "jack",
  "lazyNumbers",
  "MeshesTools",
  "MinkowskiSum",
  "multibridge",
  "PolygonSoup" %hence% c("Boov", "MeshesTools", "MinkowskiSum"),
  "qspray" %hence% c("jack"),
  "RationalMatrix",
  "sphereTessellation",
  "surveyvoi",

  # Packages requiring OpenCV (https://opencv.org/)
  "image.textlinedetector",

  # Packages requiring SWI-Prolog
  "rolog" %hence% c("mathml", "rswipl"),

  # Packages requiring protobuf (but somehow fails)
  "factset.protobuf.stach.v2",
  "tfevents",
  "traveltimeR",

  # Packages that fail for other/unknown reasons
  "landsepi",
  "valse",

  # Bioconductor packages currently broken in Bioc 3.17
  "BGmix", "ChIC", "DeepBlueR", "FLAMES", "NanoMethViz", "omada", "OmicsLonDA", "Rarr", "tscR",
  
  ""
)
pkgs_excl <- sort(pkgs_excl)

message(sprintf("Packages excluded: [n=%d] %s", length(pkgs_excl), paste(pkgs_excl, collapse = ", ")))
pkgs <- setdiff(pkgs, pkgs_excl)

message(sprintf("Number of packages to install: %d", length(pkgs)))

# -------------------------------------------------------------------------------------
# Package requiring special care on Wynton/C4
# -------------------------------------------------------------------------------------
if (!nzchar(system.file(package = "Rmpi"))) {
  install.packages("Rmpi", configure.args="--with-Rmpi-include=$MPI_INCLUDE --with-Rmpi-libpath=$MPI_LIB --with-Rmpi-type=OPENMPI")
}

if (!nzchar(system.file(package = "pbdMPI"))) {
  install.packages("pbdMPI", configure.args="--with-mpi-libpath=$MPI_LIB --with-mpi-type=OPENMPI")
}

if (!nzchar(system.file(package = "bigGP"))) {
  install.packages("bigGP", configure.args="--with-mpi-libpath=$MPI_LIB --with-mpi-type=OPENMPI")
}

if (!nzchar(system.file(package = "udunits2"))) {
  install.packages("udunits2", configure.args="--with-udunits2-include=/usr/include/udunits2")
}


chunk_size <- 50L
nchunks <- ceiling(length(pkgs) / chunk_size)
sets <- parallel::splitIndices(length(pkgs), nchunks)
message(sprintf("Number of install chunks: %d (%d packages per chunk)", length(sets), chunk_size))

for (kk in seq_along(sets)) {
  set <- sets[[kk]]
  pkgs_kk <- pkgs[set]

  message(sprintf("Current time: %s", Sys.time()))

  ## Skip already installed packages
  db <- utils::installed.packages()
  skip <- unclass(db[, "Package"])
  message(sprintf("Number of installed packages: %d", length(skip)))
  
  pkgs_kk <- setdiff(pkgs_kk, skip)
  message(sprintf("Packages to install: [n=%d] %s", length(pkgs_kk), paste(unique(c(head(pkgs_kk, 6), "...", tail(pkgs_kk, 3))), collapse = ", ")))

  t0 <- Sys.time()
  utils::install.packages(pkgs_kk)
  dt <- Sys.time() - t0

  message(sprintf("Processing time: %s", dt))
}

file.remove(".lock")

db <- utils::installed.packages()
pkgs_done2 <- unclass(db[, "Package"])
message(sprintf("Number of installed packages: %d", length(pkgs_done2)))
new <- setdiff(pkgs_done2, pkgs_done)
message(sprintf("Number of packages installed this round: %d", length(new)))

pkgs_failed <- setdiff(pkgs, pkgs_done2)
message(sprintf("Packages that failed to install: [n=%d] %s", length(pkgs_failed), paste(pkgs_failed, collapse = ", ")))

dt <- Sys.time() - t0
message(sprintf("Total processing time: %s", format(dt)))

message(sprintf("Finish time: %s", Sys.time()))
