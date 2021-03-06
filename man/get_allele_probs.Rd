% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_allele_probs.R
\name{get_allele_probs}
\alias{get_allele_probs}
\title{Get the haplotype probs nearest to the given chr and position.}
\usage{
get_allele_probs(chr, pos, genoprobs, map)
}
\arguments{
\item{chr}{character indicating the chromosome to use. This must match one of the names of genoprobs and map.}

\item{pos}{numeric value in Mb indicating the position on the chromosome.}

\item{genoprobs}{qtl2-style list of genoprobs containing 3-dimensional arrays of allele probs, one for each chromosome. Samples in rows, 8 founders in columns, markers in slices.}

\item{map}{qtl2-style list containing numeric vectors of marker positions in Mb.}
}
\value{
n x 8 numeric matrix.
}
\description{
Get the haplotype probs nearest to the given chr and position.
}
\examples{
ap = get_allele_probs(chr = "1", pos = 5.0, genoprobs = genoprobs, map = map)
}
