# Building R from source

## Dependencies

### Debian

Here are some additional packages I had to install in order to install R on the Raspberry OS:

```sh
sudo apt install gfortran
sudo apt install libreadline-dev
sudo apt install libx11-dev  ## Not 100% sure this is needed
sudo apt install libxt-dev
sudo apt install libbz2-dev
sudo apt install liblzma-dev
sudo apt install libpcre2-dev
sudo apt install libcurl4-openssl-dev
sudo apt install libicu-dev   ## optional, but required for ICU support
sudo apt install default-jdk  ## required rJava
```

Note that I had several dependencies already installed prior to this, so this is not a complete list of required package dependencies.
