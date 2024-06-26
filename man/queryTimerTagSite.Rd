% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/queryTimerTagSite.R
\name{queryTimerTagSite}
\alias{queryTimerTagSite}
\title{PTAGIS Test Tag Detections}
\source{
\url{http://api.ptagis.org}
}
\usage{
queryTimerTagSite(site_code = NULL, year = NULL, api_key = NULL)
}
\arguments{
\item{site_code}{PTAGIS site code}

\item{year}{Calendar year to be queried}

\item{api_key}{PTAGIS API key, given to individual users}
}
\description{
Query and download complete capture history for one test tag from PTAGIS for an entire calendar year. May take awhile to run.
}
\examples{
#queryTimerTagSite(site_code = "LWE", year = 2023)
}
\author{
Kevin See
}
