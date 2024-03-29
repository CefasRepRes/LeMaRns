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

Downstream dependencies
-----------------------

There are currently no downstream dependencies for this package.

Resubmission 1
--------------

This is a resubmission. In this version I have:

-   changed the descriptions of the package. It now reads: Set up, run and explore the outputs of the Length-based Multi-species model (LeMans; Hall et al. 2006; <doi:10.1139/f06-039>), focused on the marine environment.

-   reduced the vignette runtime by precomputing the results for the lengthy parts.

-   added the ORCID identifier for the authors.

Resubmission 2
--------------

This is a resubmission. In this version I have:

-   changed the Title field to be in title case. It now reads: Length-Based Multispecies Analysis by Numerical Simulation.

Update Version: 0.1.3
--------------

We have changed the maintainer from michael.spence@cefas.co.uk to michael.spence@cefas.gov.uk due to the change of email address at Cefas.
