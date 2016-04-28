# Load one or more packages into memory, installing as needed.
# https://github.com/brianhigh/imp ; License: Public Domain (CC0 1.0)
load.pkgs <- function(pkgs, repos = 'http://cran.r-project.org') {
    is.installed <- function(x) x %in% installed.packages()[,"Package"]
    inst.cran <- function(x) install.packages(x, quiet = TRUE, repos = repos)
    result <- sapply(pkgs, function(x) { 
        if (! is.installed(x)) inst.cran(x)
        library(x, character.only = TRUE)
    })
}
