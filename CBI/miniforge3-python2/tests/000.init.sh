## The Conda Python 2 environment provides its own local libraries
export LD_LIBRARY_PATH="${PREFIX:?}/lib:${LD_LIBRARY_PATH}"
