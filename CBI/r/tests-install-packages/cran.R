message(sprintf("Start time: %s", Sys.time()))

if (utils::file_test("-f", ".lock")) stop("There is already another process running (./.lock file exists)")
file.create(".lock")

t0 <- Sys.time()
message(sprintf("Current time: %s", t0))

if (!requireNamespace("parallelly", quietly = TRUE)) install.packages("parallelly")

options(Ncpus = parallelly::availableCores())
message(sprintf("Number of parallel installs: %d", getOption("Ncpus")))

if (getOption("repos")[["CRAN"]] == "@CRAN@") chooseCRANmirror(ind = 1L)

repos <- getOption("repos")
message(sprintf("R package repositories: [n=%d] %s", length(repos), paste(names(repos), sQuote(repos), sep = "=", collapse = ", ")))

db <- utils::available.packages()
pkgs <- pkgs_avail <- unclass(db[, "Package"])
message(sprintf("Number of available packages: %d", length(pkgs_avail)))

db <- utils::installed.packages()
skip <- pkgs_done <- unclass(db[, "Package"])
message(sprintf("Number of installed packages: %d", length(pkgs_done)))
pkgs <- setdiff(pkgs, skip)

# -------------------------------------------------------------------------------------
# Packages requiring dependencies not available on C4/Wynton
# -------------------------------------------------------------------------------------
`%hence%` <- function(lhs, rhs) c(lhs, rhs)

pkgs_cran_excl <- c(
  ## Packages that require CPLEX (https://www.ibm.com/products/ilog-cplex-optimization-studio)
  "Rcplex" %hence% c("ROI.plugin.cplex", "otinference", "CVXR", "designmatch", "relations", "sbw"),  ## configure: error: CPLEX include directory ./include does not exist

  ## Packages that require OpenCL (https://www.khronos.org/opencl/)
  "gpuMagic",
  "OpenCL",

  ## Packages requiring 'MeCab' library
  "RcppMeCab", ## Error: package or namespace load failed for ‘RcppMeCab’ in dyn.load(file, DLLpath = DLLpath, ...): ... undefined symbol: mecab_model_new_tagger
  "RmecabKo",  ## nouns.cpp:10:10: fatal error: mecab.h: No such file or directory

  ## Packages that require .NET framework
  "rawrr" %hence% c("MsBackendRawFileReader"), ##  The cross platform, open source .NET framework (mono) is not available. Consider to install 'apt-get install mono-runtime' on Linux

  ## Packages that require the GLPK library
  "Rglpk" %hence% c("cosso", "designmatch", "FRAPO", "LPmerge", "optrefine", "stratbr", "TukeyRegion", "Bergm", "ConcordanceTest", "eatATA", "ffsimulator", "fPortfolio", "gemtc", "hdme", "HyRiM", "ITRSelect", "kantorovich", "lpda", "MCDA", "MSCMT", "MultAlloc", "multinomineq", "natstrat", "npbr", "otinference", "parma", "ROI.models.miplib", "ROI.plugin.glpk", "sdcTable", "strand", "StratifiedSampling", "visaOTR"),
  
  ## Packages that require OCI libraries
  "ROracle" %hence% c("ora"), ## OCI libraries not found

  ## Packages requiring 'OpenBUGS' library (https://openbugs.net)
  ## OpenBUGS is a 32-bit library and requires special build tools
  "BRugs" %hence% c("bcrm", "dclone", "miscF", "R2WinBUGS"),
    "dclone" %hence% c("dcmle", "PVAClone", "sharx", "ordinalbayes"),
    "miscF" %hence% c("agRee", "PottsUtils"),

  ## Packages requiring 'Poppler Glib interface' (poppler-glib-devel)
  "Rpoppler",

  # Packages that requires 'QuantLib' library (https://www.quantlib.org/)
  "RQuantLib" %hence% c("bizdays", "rtsdata"),

  ## Packages that require 'SYMPHONY' library
  "Rsymphony" %hence% c("adea", "PortfolioOptim", "prioriactions", "ROI.plugin.symphony"),

  # Packages requiring GMP (GNU Multiple Precision Arithmetic Library)
  "interpolation" %hence% c("weird"),
  "RationalMatrix" %hence% c("qspray"),
  "qspray" %hence% c("jack", "polyhedralCubature"),
  
  # Packages requiring GMP and MPFR (GNU Multiple Precision Floating-Point Reliable Library)
  "Apollonius",
  "jack",
  "multibridge",
  "ratioOfQsprays",
  "sphereTessellation",
  "symbolicQspray",
  "surveyvoi",  ## ... depends on many more libraries too

  # Packages requiring OpenCV (https://opencv.org/)
  "opencv",
  "image.textlinedetector",

  # Packages requiring SWI-Prolog
  "rolog" %hence% c("mathml", "rswipl"),

  # Packages requiring grpc (grpc-devel)
  "bigrquerystorage",

  # Packages requiring fluidsynth
  "fluidsynth",

  # Packages requiring COIN-Or Clp
  "pcaL1",

  # Packages requiring ZeroMQ/ZMQ
  "rzmq",
  
  # Packages that fail for other/unknown reasons
  "rgoslin"  ## Bioc [compile error]
)


# --------------------------------------------------------------
## Packages requiring Tcl (>= 8.6) [December 2012]
# --------------------------------------------------------------
pkgs_cran_tcl_86 <- c(
  "loon" %hence% c("loon.ggplot", "loon.shiny", "loon.tourr", "rfviz", "zenplots", "diveR"),
  "switchboard",  ## error: [tcl] invalid command name "ttk::style"

  # Packages that require special libraries or dependencies
  "cncaGUI"       ## requires 'Tcl/Tk package BWidget'
)

## Comment: To see version, call: tclsh <<< "puts [info patchlevel]"
## * CentOS 7: Tcl 8.5.13
## * Rocky 8: Tcl 8.6.8
## * Ubuntu 22.04: Tcl 8.6.12
if (numeric_version(tcltk::tclVersion()) < "8.6") {
  pkgs_cran_excl <- c(pkgs_cran_excl, pkgs_cran_tcl_86)
}


## Packages that get stuck an endless "tcltk2" loop if X11 is not available, cf. strace -p <PID>
pkgs_cran_tcltk2_x11 <- c(
  "biplotbootGUI",
  "cncaGUI",
  "multibiplotGUI"
)

if (!isTRUE(capabilities("X11"))) {
  pkgs_cran_excl <- c(pkgs_cran_excl, pkgs_cran_tcltk2_x11)
}


# --------------------------------------------------------------
# LEGACY: Archived CRAN packages
# --------------------------------------------------------------
pkgs_cran_archived <- c(
  ## Packages requiring 'rrdtool-devel' (installed on C4 but not Wynton)
  "rrd",          ## archived on 2022-10-03
  
  # Packages requiring gmp or mpfr
  "PolygonSoup" %hence% c("Boov", "MeshesTools", "MinkowskiSum"), ## archived on 2023-08-03
  "Boov",         ## archived on 2023-08-03
  "MeshesTools",  ## archived on 2023-08-03
  "MinkowskiSum", ## archived on 2023-08-03
  "AlphaHull3D",  ## archived on 2023-08-15
  "cgalMeshes",   ## archived on 2023-08-15
  "delaunay",     ## archived on 2023-08-15
  "cgalPolygons", ## archived on 2023-08-28
  "lazyNumbers"   ## archived on 2023-08-28
)

# --------------------------------------------------------------
# Bioconductor
# --------------------------------------------------------------
# Bioconductor package with missing system libraries
pkgs_excl_bioc <- c(
  ## Packages that require OpenBabel (https://openbabel.org/)
  "ChemmineOB" %hence% c("RMassBank")  ## Requires <openbabel/obutil.h>
)

# Bioconductor 3.17
pkgs_excl_bioc_3_17 <- c(
  ## Broken [2023-05]
  "BGmix", "ChIC", "DeepBlueR", "FLAMES", "NanoMethViz", "omada", "OmicsLonDA", "Rarr", "tscR"
)

# Bioconductor 3.18
pkgs_excl_bioc_3_18 <- c(
  ## Depends on archived CRAN packages
  "autonomics",        ## 'assertive.{base,files,numbers,sets} archived on 2024-04-12
  "clusterExperiment", ## 'howmany' archived on 2024-03-24
  "netSmooth",         ## 'howmany' archived on 2024-03-24
  
  ## Broken [2024-05-03]
  "BASiCS" %hence% c("BASiCStan"), ## Error : in method for ‘Summary’ with signature ‘x="BASiCS_Chain"’:  arguments (‘na.rm’) after ‘...’ in the generic must appear in the method, in the same place at the end of the argument list
  "IFAA", ## Error: object ‘crossprod’ is not exported by 'namespace:MatrixExtra'

  # Packages requiring gtkmm
  "HilbertVisGUI",

  # Packages requires libsbml
  "rsbml" %hence% c("HilbertVisGUI", "BiGGR")
)

# Bioconductor 3.19 [2024-05-03]
pkgs_excl_bioc_3_19 <- c(
  # Deprecated
  "cliqueMS",
  
  # Broken
  "isomiRs",
  "netOmics",
  "RLSeq",
  "easyRNASeq",

  ## Archive CRAN packages
  "qlcMatrix" %hence% c("MetaScope"),            ## archived on 2023-11-29
  "dnet" %hence% c("Pi", "RandomWalkRestartMH"), ## archived on 2024-01-30
  "XML2R" %hence% c("VarfromPDB", "nanotatoR"),  ## archived on 2024-03-24
  "ensurer" %hence% c("TissueEnrich"),           ## archived on 2024-04-12
  
  # Packages requires libsbml
  "rsbml" %hence% c("HilbertVisGUI", "BiGGR")
)

bioc_version <- Sys.getenv("R_BIOC_VERSION", "3.19")
if (bioc_version == "3.19") {
  pkgs_excl_bioc <- c(pkgs_excl_bioc, pkgs_excl_bioc_3_19)
} else if (bioc_version == "3.18") {
  pkgs_excl_bioc <- c(pkgs_excl_bioc, pkgs_excl_bioc_3_18)
} else if (bioc_version == "3.17") {
  pkgs_excl_bioc <- c(pkgs_excl_bioc, pkgs_excl_bioc_3_17)
}

pkgs_excl <- c(pkgs_cran_excl, pkgs_excl_bioc)

pkgs_excl <- pkgs_excl[nzchar(pkgs_excl)]
pkgs_excl <- unique(sort(pkgs_excl))

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

if (!nzchar(system.file(package = "valse"))) {
  ## CRAN package 'valse' uses RcppGSL:::LdFlags() in its Makefile without declaring a dependency on 'RcppGSL'
  install.packages("RcppGSL")
}

if (!nzchar(system.file(package = "tfevents"))) {
  ## CRAN package 'tfevents' fail to compile with GCC (>= 13), cf. https://github.com/traveltime-dev/traveltime-sdk-r/issues/35
  stop("Package 'tfevents' requires GCC (<= 12); make sure to 'module load CBI scl-gcc-toolset/12' before starting R")
  install.packages("tfevents")
}

if (!nzchar(system.file(package = "landsepi"))) {
  # Packages requiring gsl
  install.packages("landsepi")
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
message(sprintf("Number of available packages: %d", length(pkgs_avail)))
message(sprintf("Number of packages installed this round: %d", length(new)))

pkgs_failed <- setdiff(pkgs, pkgs_done2)
message(sprintf("Packages that failed to install: [n=%d] %s", length(pkgs_failed), paste(pkgs_failed, collapse = ", ")))

dt <- Sys.time() - t0
message(sprintf("Total processing time: %s", format(dt)))

message(sprintf("Finish time: %s", Sys.time()))
