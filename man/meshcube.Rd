% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meshcube.r
\name{meshcube}
\alias{meshcube}
\title{calculate the corners of a mesh's bouning box}
\usage{
meshcube(x)
}
\arguments{
\item{x}{object of class 'mesh3d'}
}
\value{
returns a 8 x 3 matrix with the coordinates of the corners of the
bounding box.
}
\description{
calculate the corners of a mesh's bouning box
}
\examples{

require(rgl)
data(boneData)
mc <- meshcube(skull_0144_ch_fe.mesh)
\dontrun{
spheres3d(mc)
wire3d(skull_0144_ch_fe.mesh)
}

}
