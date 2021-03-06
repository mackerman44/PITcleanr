% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/queryCapHist.R
\name{queryCapHist}
\alias{queryCapHist}
\title{PTAGIS Detection History}
\source{
\url{http://www.ptagis.org}
}
\usage{
queryCapHist(tagCode = NULL, configuration = NULL)
}
\arguments{
\item{tagCode}{PTAGIS tag code}
}
\description{
Query and download complete capture history for one tag from PTAGIS
}
\examples{
queryCapHist(tagCode = '384.3B23A0A6EE')
}
\author{
Kevin See
}
