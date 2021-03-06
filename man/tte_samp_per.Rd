% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tte_samp_per.R
\name{tte_samp_per}
\alias{tte_samp_per}
\title{Sampling period length}
\usage{
tte_samp_per(deploy, lps)
}
\arguments{
\item{deploy}{deploy object}

\item{lps}{movement speed in length units (same as camera area measurement) per second}
}
\value{
The average length of time, in seconds, needed to cross a camera viewshed
}
\description{
Sampling period length
}
\section{Warning}{

This function only calculates a rough estimate of the time needed to move across a camera. 
There may be better ways.
}

\examples{
deploy <- data.frame(
  cam = c(1, 2, 2, 2),
  start = as.POSIXct(c("2015-12-01 15:00:00",
                       "2015-12-08 00:00:00", 
                       "2016-01-01 00:00:00", 
                       "2016-01-02 00:00:00"),
                     tz = "GMT"),
  end = as.POSIXct(c("2016-01-05 00:00:00", 
                     "2015-12-19 03:30:00", 
                     "2016-01-01 05:00:00",
                     "2016-01-05 00:00:00"), 
                   tz = "GMT"),
  area = c(300, 200, 200, 450)
)
samp_per(deploy, lps = 2)
}
