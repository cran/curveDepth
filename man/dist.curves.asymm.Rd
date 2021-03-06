% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{dist.curves.asymm}
\alias{dist.curves.asymm}
\title{Distance for curves}
\usage{
dist.curves.asymm(curvesRows, curvesCols, oneWay = FALSE, verbosity = 0L)
}
\arguments{
\item{curvesRows}{A list where each element is a function being a list
containing a matrix \code{coords} (values, d columns).}

\item{curvesCols}{A list where each element is a function being a list
containing a matrix \code{coords} (values, d columns).}

\item{oneWay}{Whether curves should be condisered as a one-directional,
\code{FALSE} by default.}

\item{verbosity}{Level of reporting messages, the higher the more progress
reports are printed, set \code{0} (default) for no messages.}
}
\value{
A matrix \code{length(curvesRows) x length(curvesCols)} with each
entry being the distance between two corresponding curves.
}
\description{
Calculates distance matrix for two samples of curves using minimax metric.
The function can be particularly useful for parallel computation of a
big distance matrix.
}
\examples{
library(curveDepth)
# Pixel-grid filling function for an image
plotGridImage <- function(dims){
  redDims1 <- dims[1] - 1
  redDims2 <- dims[2] - 1
  for (i in 1:(dims[1] - 1)){
    lines(c(i / redDims1 - 0.5 / redDims1,
            i / redDims1 - 0.5 / redDims1),
          c(0 - 0.5 / redDims2, 1 + 0.5 / redDims2),
          lwd = 1, lty = 3, col = "lightgray")
    lines(c(0 - 0.5 / redDims1, 1 + 0.5 / redDims1),
          c(i / redDims2 - 0.5 / redDims2,
            i / redDims2 - 0.5 / redDims2),
          lwd = 1, lty = 3, col = "lightgray")
  }
  rect(0 - 0.5 / redDims1, 0 - 0.5 / redDims2,
       1 + 0.5 / redDims1, 1 + 0.5 / redDims2)
}
# Load two Sevens and one One, plot them,
# and transform to curves
data("mnistShort017")
# First Seven
firstSevenDigit <- mnistShort017$`7`[, , 5]
image(as.matrix(rev(as.data.frame(firstSevenDigit))),
      col = gray((255:0) / 256), asp = 1,
      xlim = c(0 - 1 / 27, 1 + 1 / 27),
      ylim = c(0 - 1 / 27, 1 + 1 / 27))
plotGridImage(dim(firstSevenDigit)[1:2])
firstSevenCurve <- images2curves(array(
  firstSevenDigit, dim = c(28, 28, 1)))[[1]]
# Second Seven
secondSevenDigit <- mnistShort017$`7`[, , 6]
image(as.matrix(rev(as.data.frame(secondSevenDigit))),
      col = gray((255:0) / 256), asp = 1,
      xlim = c(0 - 1 / 27, 1 + 1 / 27),
      ylim = c(0 - 1 / 27, 1 + 1 / 27))
plotGridImage(dim(secondSevenDigit)[1:2])
secondSevenCurve <- images2curves(array(
  secondSevenDigit, dim = c(28, 28, 1)))[[1]]
# A One
aOneDigit <- mnistShort017$`1`[, , 1]
image(as.matrix(rev(as.data.frame(aOneDigit))),
  col = gray((255:0) / 256), asp = 1,
  xlim = c(0 - 1 / 27, 1 + 1 / 27),
  ylim = c(0 - 1 / 27, 1 + 1 / 27))
plotGridImage(dim(aOneDigit)[1:2])
aOneCurve <- images2curves(array(
  aOneDigit, dim = c(28, 28, 1)))[[1]]
# Caculate distances between all the curves
distMatrix <- matrix(0, 3, 3)
distMatrix[3, 1:2] <- distMatrix[1:2, 3] <-
  dist.curves.asymm(list(
    firstSevenCurve, secondSevenCurve), list(aOneCurve))
distMatrix[2, 1] <- distMatrix[1, 2] <-
  dist.curves.asymm(
    list(firstSevenCurve), list(secondSevenCurve))
# Print distance matrix
print(distMatrix)
}
\references{
Lafaye De Micheaux, P., Mozharovskyi, P. and Vimond, M. (2018).
Depth for curve data and applications.
}
