# Load all packages referenced in this script, installing as necessary.
# Applies to calling script when sourced using the source() function.
# Example usage: source("imp.R"); load.my.pkgs()
# https://github.com/brianhigh/imp ; License: Public Domain (CC0 1.0)

# Load one or more packages into memory, installing as needed.
load.pkgs <- function(pkgs, repos = "http://cran.r-project.org") {
    result <- sapply(pkgs, function(x) { 
        if (!suppressWarnings(require(x, character.only = TRUE))) {
            install.packages(x, quiet = TRUE, repos = repos)
            library(x, character.only = TRUE)}})
}

# If running as a script, try to load all packages referenced in this script.
load.my.pkgs <- function() {
    if (length(sys.frames()) > 0) {
        filename <- sys.frame(1)$ofile
        pkgs <- readLines(filename, warn = FALSE)
        pkgs <- unlist(strsplit(x = pkgs, split = ";[ ]*"))
        pkgs.regex <- "^[^#]*(library|require|install\\.packages)\\s*\\("
        pkgs <- pkgs[grepl(pkgs.regex, pkgs)]
        pkgs <- gsub(".*\\((.*)\\).*", "\\1", pkgs)
        pkgs <- unlist(strsplit(x = pkgs, split = ",[ ]*"))
        pkgs <- gsub('["()]', "", pkgs)
        pkgs <- unique(pkgs[!grepl("=|^x$", pkgs)])
        load.pkgs(pkgs)
    }
}
