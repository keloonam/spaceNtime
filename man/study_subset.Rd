% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/study_subset.R
\name{study_subset}
\alias{study_subset}
\title{Subset camera-related data}
\usage{
study_subset(x, start_col, end_col = NULL, study_start, study_end)
}
\arguments{
\item{x}{a dataframe or tibble with start and end columns}

\item{start_col}{the name of the start column in x}

\item{end_col}{the name of the end column in x. Default = NULL}

\item{study_start}{the first part of the interval you want to subset by}

\item{study_end}{the end of the interval to subset by}
}
\value{
a filtered dataframe or tibble
}
\description{
Keep rows of data where start_col and (optional) end_col lie within an 
inclusive interval defined by study_start and study_end
}
\examples{
df <- data.frame(cam = c(1,1,2,2),
            datetime = as.POSIXct(c("2016-01-02 12:00:00",
                                    "2016-01-03 13:12:00",
                                    "2016-01-02 14:00:00",
                                    "2016-01-03 16:53:42"),
                                   tz = "GMT"),
                  a = c(850, 850, 1100, 1100),
                  count = c(1, 0, 0, 2))
d <- as.POSIXct(c("2016-01-01 00:00:00", "2016-01-02 23:59:59"), tz = "GMT")
study_subset(df, "datetime", NULL, d[1], d[2])

}
