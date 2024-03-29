% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NS_par.R
\docType{data}
\name{NS_mixed_fish}
\alias{NS_mixed_fish}
\title{Gear selectivity data frame}
\format{
A data frame with 21 rows and 4 variables, including:
\describe{
\item{\code{catch_species}}{A character string describing the species to apply the catchability curve to.}
 \item{\code{curve}}{A character vector describing the type of curve to be used to determine the catchability of each species by the fishing gear.}
 \item{\code{gear_name}}{A character string describing the name of the gear.}
 \item{\code{max_catchability}}{A numeric vector describing the maximum catchability for each catchability curve.}
}
}
\usage{
NS_mixed_fish
}
\description{
A gear selectivity data frame for the 21 species in \code{NS_par}.
}
\references{
Thorpe, R.B., Dolder, P.J. , Reeves, S., Robinson, P., Jennings, S. (2015). Assessing fishery and ecological consequences of alternative management options for multispecies fisheries \emph{ICES Journal of Marine Science}, 73(6):1503-1512.
}
\keyword{datasets}
