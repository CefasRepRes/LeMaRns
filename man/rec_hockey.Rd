% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_recruits.R
\name{rec_hockey}
\alias{rec_hockey}
\title{The hockey-stick stock recruitment function}
\usage{
rec_hockey(SSB, rec_args)
}
\arguments{
\item{SSB}{A numeric value representing the Spawning Stock Biomass (SSB) of a given species (g).}

\item{rec_args}{A list object of length \code{nfish}, with each element in the list including a value of \code{a} and \code{b} for each species. \code{a} is a positive numeric value, often referred to as the \emph{density-independent} parameter. The default is 1. \code{b} is a positive numeric value, often referred to as the \emph{density-dependent} parameter. The default is 0.001.}
}
\value{
A numeric value representing the number of recruits of a given species.
}
\description{
Calculates the number of recruits as given by the hockey-stick stock recruitment function.
}
\details{
The stock recruitment function is defined as \code{min(a*(SSB/1e9), b)}.
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

rec_hockey(SSB[1], recruit_params[[1]])
}
\references{
Barrowman, N.J., Myers, R.A. (2000).  Still more spawner-recruit curves: the hockey stick and its generalisations. \emph{Canadian Journal of Fisheries and Aquatic Science}, 57:665–676.

Thorpe, R.B., Le Quesne, W.J.F., Luxford, F., Collie, J.S., Jennings, S. (2015). Evaluation and management implications of uncertainty in a multispecies size-structured model of population and community responses to fishing. \emph{Methods in Ecology and Evolution}, 6:49-58.
}
\seealso{
\code{\link{calc_recruits}}, \code{\link{make_rec_fun}}, \code{\link{get_rec_fun}}, \code{\link{rec_BH}}, \code{\link{rec_Ricker}}, \code{\link{rec_const}}, \code{\link{rec_linear}} and \code{\link{calc_SSB}}
}
