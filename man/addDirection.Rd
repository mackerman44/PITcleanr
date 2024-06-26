% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/addDirection.R
\name{addDirection}
\alias{addDirection}
\title{Add Direction}
\usage{
addDirection(compress_obs = NULL, parent_child = NULL, direction = "u")
}
\arguments{
\item{compress_obs}{The result of `compress()`.}

\item{parent_child}{data frame with at least `parent` and `child` columns.
Can be created with `buildParentChild()` function.}

\item{direction}{the direction of movement. Parent-child tables are generally built imagining parents as downstream from children. Assuming that's the case, should the paths be upstream (`u` or `upstream`), the default, or downstream (`d` or `downstream`)?}
}
\value{
a tibble
}
\description{
Based on the compressed PIT tag observations, and a
parent-child table, determines the direction of movement leading to
each detection.
}
\examples{
addDirection()
}
\author{
Kevin See
}
