% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_M1.R
\name{calc_M1}
\alias{calc_M1}
\alias{get_M1}
\alias{calc_M1_stdRNM}
\alias{calc_M1_lin}
\alias{calc_M1_constRNM}
\title{Calculate background mortality}
\usage{
calc_M1(
  nsc,
  sc_Linf,
  phi_min,
  natmort_opt = rep("std_RNM", length(sc_Linf)),
  Nmort = rep(0.8, length(sc_Linf)),
  prop = rep(0.75, length(sc_Linf))
)

get_M1(nsc, sc_Linf, natmort_opt, Nmort, prop)

calc_M1_stdRNM(nsc, sc_Linf, Nmort = 0.8, prop = 0.75)

calc_M1_lin(nsc, sc_Linf, Nmort = 0.8)

calc_M1_constRNM(nsc, sc_Linf, Nmort = 0.8)
}
\arguments{
\item{nsc}{A numeric value representing the number of length classes in the model.}

\item{sc_Linf}{A numeric vector of length \code{nfish} for \code{calc_M1} and 1 for \code{get_M1}, \code{calc_M1_stdRNM}, \code{calc_M1_constRNM} and \code{calc_M1_lin}, representing the length class at which each species reaches its asymptotic length.}

\item{phi_min}{A numeric value representing the time step of the model.}

\item{natmort_opt}{A character vector of length \code{nfish} for \code{calc_M1} and 1 for \code{get_M1}, describing the mortality function to be used for each species. By default, \code{natmort_opt} takes the value \code{"std_RNM"}, but it can also take \code{"constant"} or \code{"linear"}. See 'Details' for more information.}

\item{Nmort}{A numeric vector of length \code{nfish} representing the maximum background mortality of each species. The default is \code{0.8} for all species.}

\item{prop}{A numeric vector of length \code{nfish} representing the proportion of length classes that have a non-zero background mortality. This parameter is required only when the \code{natmort_opt} mortality function is used. The default is \code{0.75}.}
}
\value{
\code{calc_M1} returns a matrix of dimensions \code{nsc} and \code{nfish} representing the background mortality of each species for each length class.

\code{get_M1} returns a numeric vector of length \code{nsc} representing the background mortality for each length class.

\code{calc_M1_stdRNM} returns a numeric vector of length \code{nsc} representing the background mortality for each length class. \code{M1=Nmort} for all length classes between \code{floor(sc_Linf*prop)} and the \code{sc_Linf}-th class and \code{M1=0} for the rest.

\code{calc_M1_lin} returns a numeric vector of length \code{nsc} representing the background mortality for each length class. \code{M1=0} for the first length class. \code{M1} then increases linearly up to and including the \code{sc_Linf}-th length class. For all length classes above \code{sc_Linf}, \code{M1=0}.

\code{calc_M1_constRNM} returns a numeric vector of length \code{nsc} representing the background mortality for each length class. \code{M1=Nmort} for all length classes up to and including the \code{sc_Linf}-th class. For all length classes above \code{sc_Linf}, \code{M1=0}.
}
\description{
Calculates the background mortality of each species in each length class per time step.
}
\details{
The background mortality is defined as the number of individuals that die per year, but not from predation or fishing

\code{N*exp(-M1)}

where \code{N} is the total number of individuals. This function allows three different models for background mortality: (1) \code{"constant"}, which gives \code{M1=Nmort} for all length classes up to and including the \code{sc_Linf}-th class; (2) \code{"std_RNM"}, which gives \code{M1=Nmort} for all length classes between \code{floor(sc_Linf*prop)} and the \code{sc_Linf}-th class and \code{M1=0} for the rest; and (3) \code{"linear"}, which gives \code{M1=0} for the first length class, followed by a linear increase in \code{M1} up to and including the \code{sc_Linf}-th length class \code{M1=Nmort} and \code{M1=0} for the rest.
}
\examples{
# Set up the inputs to the function - species-independent parameters
nfish <- nrow(NS_par)
nsc <- 32
maxsize <- max(NS_par$Linf)*1.01 # the biggest size is 1\% bigger than the largest Linf
l_bound <- seq(0, maxsize, maxsize/nsc); l_bound <- l_bound[-length(l_bound)]
u_bound <- seq(maxsize/nsc, maxsize, maxsize/nsc)
mid <- l_bound+(u_bound-l_bound)/2

# Set up the inputs to the function - species-specific parameters
Linf <- NS_par$Linf # the von-Bertalanffy asymptotic length of each species (cm).
W_a <- NS_par$W_a # length-weight conversion parameter.
W_b <- NS_par$W_b # length-weight conversion parameter.
k <- NS_par$k # the von-Bertalnaffy growth parameter.
Lmat <- NS_par$Lmat # the length at which 50\\% of individuals are mature (cm).

# Get phi_min
tmp <- calc_phi(k, Linf, nsc, nfish, u_bound, l_bound, calc_phi_min=FALSE,
                  phi_min=0.1) # fixed phi_min
phi_min <- tmp$phi_min

# Calculate growth increments
tmp <- calc_ration_growthfac(k, Linf, nsc, nfish, l_bound, u_bound, mid, W_a, W_b, phi_min)
sc_Linf <- tmp$sc_Linf

# Calculate background mortality with natmort_opt="std_RNM", Nmort=0.8 and prop=0.75 for all species
M1 <- calc_M1(nsc, sc_Linf, phi_min)

# Get background mortality with natmort_opt="std_RNM", Nmort=0.8 and prop=0.75 for all species
natmort_opt <- "std_RNM"
Nmort <- 0.8
prop <- 0.75
get_M1(nsc, sc_Linf, natmort_opt, Nmort, prop)

# Calculate standard residual background mortality
M1_stdRNM <- calc_M1_stdRNM(nsc, sc_Linf)

# Calculate linear background mortality
M1_lin <- calc_M1_lin(nsc, sc_Linf,Nmort=0.3)

# Calculate constant residual background mortality
M1_constRNM <- calc_M1_constRNM(nsc, sc_Linf)
}
\references{
Thorpe, R.B., Jennings, S., Dolder, P.J. (2017). Risks and benefits of catching pretty good yield in multispecies mixed fisheries. \emph{ICES Journal of Marine Science}, 74(8):2097-2106.
}
