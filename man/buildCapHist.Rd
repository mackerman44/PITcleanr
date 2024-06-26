% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/buildCapHist.R
\name{buildCapHist}
\alias{buildCapHist}
\title{Build capture history}
\usage{
buildCapHist(
  filter_ch = NULL,
  parent_child = NULL,
  configuration = NULL,
  keep_cols = c("tag_code"),
  drop_nodes = T,
  ...
)
}
\arguments{
\item{filter_ch}{filtered capture history as returned by the `filterDetections()` function, which has then been verified by a user and all blank or NA `user_keep_obs` entries have been completed.}

\item{parent_child}{parent-child table. Could be created from `buildParentChild()` from `PITcleanr` package.}

\item{configuration}{configuration file. Could be created from `buildConfig()` from `PITcleanr` package.}

\item{keep_cols}{what columns from `filter_ch` should be kept in the final output. These should be columns that are consistent for each tag. Default value is `tag_code`.}

\item{drop_nodes}{After constructing a capture history with one row per tag, should the various columns containing specific node detections be dropped (`TRUE`) or retained (`FALSE`).}

\item{...}{other inputs to the `defineCapHistCols` if desired.}
}
\value{
A tibble or data.frame with one row per tag, containing at least a column called `cap_hist` where each entry is a string of 0s and 1s corresponding to whether that tag was detected at each node or not. The order of the columns is determined by `defineCapHistCols`, and the user can input arguments to that function here.
}
\description{
Based on a compressed and filtered capture history, translate into a capture history matrix.
}
\examples{
buildConfig()

}
\author{
Kevin See
}
