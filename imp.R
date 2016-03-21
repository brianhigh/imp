# imp: Install missing packages
#
# https://github.com/brianhigh/imp ; License: Public Domain (CC0 1.0)
#
# Load all packages referenced in a script, installing as necessary.
# Applies to calling script when sourced using the source() function.
#
# Example usage: source('imp.R'); imp()

# Load one or more packages into memory, installing as needed.
load.pkgs <- function(pkgs, repos = 'http://cran.r-project.org') {
    result <- sapply(pkgs, function(x) { 
        if (!suppressWarnings(require(x, character.only = TRUE))) {
            install.packages(x, quiet = TRUE, repos = repos)
            library(x, character.only = TRUE)}})
}

# Try to find all packages referenced in an R script with library, require, etc.
# Only works for library, require, etc., calls which fit on a single line.
find.pkgs <- function(filename = sys.frame(1)$ofile) {
    # Construct a regular expression to use for finding package names
    find.func = c('library', 'require', 'install.packages')
    func.regex <- gsub('\\.', '\\\\.', paste(find.func, collapse = '|'))
    pkgs.regex <- paste0('^[^#]*(', func.regex, ')\\s*\\(')
    
    # Read in script as text, parse and extract package names.
    pkgs <- readLines(filename, warn = FALSE)
    pkgs <- unlist(strsplit(x = pkgs, split = ';\\s*'))
    pkgs <- pkgs[grepl(pkgs.regex, pkgs)]
    pkgs <- gsub('.*\\((.*)', '\\1', pkgs)
    pkgs <- gsub('(.*)\\).*', '\\1', pkgs)
    pkgs <- unlist(strsplit(x = pkgs, split = ',\\s*'))
    pkgs <- gsub('[\'"()]', '', pkgs)
    pkgs <- unique(pkgs[!grepl('=|^x$', pkgs)])
    return(pkgs)
}

# Find and load packages, installing as necessary.
imp <- function(repos = 'http://cran.r-project.org') {
    load.pkgs(find.pkgs(), repos = repos)
}