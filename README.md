# imp: install missing packages

Description: R script to install missing packages referenced from a calling script.

This repository and the R script it hosts has been released into the Public
Domain. Feel free to use it without restriction. See the LICENSE file for
more information. (Creative Commons Legal Code CC0 1.0 Universal)

This `imp.R` script can be sourced from another R script to load all packages
referenced in that R script (through `library`, `require`, and 
`install.packages`), installing as necessary.

Using `imp.R` will make your scripts easier to run by novices who may have 
difficulty installing packages or who may not understand when a script 
crashes due to missing packages. You will also be able to avoid having
to put package installation commands into your scripts, which might
needlessly install a package to a system which already had that package.

The idea is to place the following code at the beginning of a script:

```
# Load all packages referenced in this script, installing as necessary.
source("imp.R"); load.my.pkgs()
```

... assuming that the path to `imp.R` is correct given its actual location.

This way, one does not have to explicitly install packages before
running the calling script, nor does the calling script need to include
commands to install packages. Simply using `require` and/or `library`
statements within the calling script for all necessary packages will be 
sufficient, whether the system running the script has the packages 
already installed or not. The `imp.R` script will search the calling
script for `library`, `require`, and `install.packages` function calls, 
attempt to load those packages passed to those functions, and attempt to 
install any packages which fail to load.

This script is similar to the R package [install.load](https://cran.r-project.org/web/packages/install.load/index.html) except that it will search your
calling script for packages to load (or install then load). It contains
a function `load.pkgs` which is like the `install_load` function in that
package. You may edit `load.pkgs` to use a different mirror.
