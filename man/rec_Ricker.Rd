% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_recruits.R
\name{rec_Ricker}
\alias{rec_Ricker}
\title{The Ricker stock recruitment function}
\usage{
rec_Ricker(SSB, rec_args)
}
\arguments{
\item{SSB}{A numeric value representing the Spawning Stock Biomass (SSB) of a given species (g).}

\item{rec_args}{A list object of length \code{nfish}, with each element in the list including a value of \code{a} and \code{b} for each species. \code{a} is a positive numeric value, often referred to as the \emph{density-independent} parameter. The default is 1. \code{b} is a positive numeric value, often referred to as the \emph{density-dependent} parameter. The default is 0.001.}
}
\value{
A numeric value representing the number of recruits of a given species.
}
\description{
Calculates the number of recruits as given by the Ricker stock recruitment function.
}
\details{
The Ricker stock recruitment function is defined as \code{a*(SSB/1e9))*exp(-b*(SSB/1e9))}.
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

# Run calc_ration_growthfac()
tmp <- calc_ration_growthfac(k, Linf, nsc, nfish, l_bound, u_bound, mid, W_a, W_b, phi_min)
sc_Linf <- tmp$sc_Linf
wgt <- tmp$wgt

# Calculate maturity
mature <- calc_mature(Lmat, nfish, mid, kappa=rep(10, nfish), sc_Linf)

# Create recruitment functions
stored_rec_funs <- get_rec_fun(rep("hockey-stick", nfish))
recruit_params <- do.call("Map", c(c, list(a=NS_par$a, b=NS_par$b)))

# Get an initial population
N0 <- get_N0(nsc, nfish, mid, wgt, sc_Linf, intercept=1e10, slope=-5)

# Calculate the SSB
SSB <- calc_SSB(mature, N0, wgt)

rec_Ricker(SSB[1], recruit_params[[1]])
}
\references{
Hall, S. J., Collie, J. S., Duplisea, D. E., Jennings, S., Bravington, M., & Link, J. (2006). A length-based multispecies model for evaluating community responses to fishing. \emph{Canadian Journal of Fisheries and Aquatic Sciences}, 63(6):1344-1359.

Ricker, W.E. (1954). Stock and recruitment. \emph{Journal of the Fisheries Research Board of Canada}, 11:559-623.
}
\seealso{
\code{\link{calc_recruits}}, \code{\link{make_rec_fun}}, \code{\link{get_rec_fun}}, \code{\link{rec_BH}}, \code{\link{rec_hockey}}, \code{\link{rec_const}}, \code{\link{rec_linear}} and \code{\link{calc_SSB}}
}
