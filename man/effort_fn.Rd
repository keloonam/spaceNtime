% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/effort_fn.R
\name{effort_fn}
\alias{effort_fn}
\title{Determine effort at each camera on each occasion}
\usage{
effort_fn(deploy, occ)
}
\arguments{
\item{deploy}{deploy object}

\item{occ}{occasions dataframe or tibble}
}
\value{
a dataframe or tibble the with the area at each camera and occasion
}
\description{
Determine effort at each camera on each occasion
}
\details{
If any occasion is missing from deploy for a camera, it is assumed 
that the camera was not working at that time.
}
\examples{
effort_fn(deploy, occ)
}
