cran-comments
================

Test environments
-----------------

-   local Windows, 10 install, R 3.5.1
-   local OS X install, R 3.5.1
-   R-hub

R CMD check results
-------------------

There were no ERRORS or WARNINGS.

There was one NOTE:

File 'LeMaRns/libs/x64/LeMaRns.dll': Found no calls to: 'R\_registerRoutines', 'R\_useDynamicSymbols'

It is good practice to register native routines and to disable symbol search.

See 'Writing portable packages' in the 'Writing R Extensions' manual.

We tried multiple fixes but could not resolve this issue.

For R-hub tests we got the same results for windows but there seems to be an issue with `BioCinstaller` on Linux machines. This is an open issue see: [github](https://github.com/r-hub/rhub/issues/279).

Downstream dependencies
-----------------------

There are currently no downstream dependencies for this package.
