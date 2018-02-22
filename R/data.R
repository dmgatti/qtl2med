#' Additive covariates to use in the mapping model.
#'
#' @format A matrix with 500 rows and 5 columns:
#' \describe{
#'   \item{sexM}{numeric indicator for sex (0 = female, 1 = male)}
#'   \item{DOwave2}{numeric indicator for DO wave 2}
#'   \item{DOwave3}{numeric indicator for DO wave 3}
#'   \item{DOwave4}{numeric indicator for DO wave 4}
#'   \item{DOwave5}{numeric indicator for DO wave 5}
#' }
"addcovar"


#' Gene expression data for genes on Chr 13.
#'
#' @format A matrix with 378 rows and 800 columns:
#' \describe{
#'    Samples are in rows and genes are in columns.
#' }
"expr"


#' Founder allele probabilities for each mouse on Chr 13.
#'
#' All chromosomes except for Chr 13 are st to NA to save space.
#' Also, the markers have been down-sampled to 1000 markers.
#' The element for Chr 13 contains a three-dimensional array of 
#' allele probabilities with samples in rows, founders in columns
#' and markers in slices.
#' 
#' @format A list with 20 elements:
#' \describe{
#'    500 rows by 8 founders by 1000 markers.
#' }
"genoprobs"


#' Physical locations for the markers.
#'
#' Each element is a vector of marker locations in Mb.
#' 
#' @format A list with 20 elements:
#' \describe{
#'    \item{1}{Marker locations on Chr 1}
#'    \item{1}{Marker locations on Chr 2}
#'    \item{1}{Marker locations on Chr 3}
#'    \item{1}{Marker locations on Chr 4}
#'    \item{1}{Marker locations on Chr 5}
#'    \item{1}{Marker locations on Chr 6}
#'    \item{1}{Marker locations on Chr 7}
#'    \item{1}{Marker locations on Chr 8}
#'    \item{1}{Marker locations on Chr 9}
#'    \item{1}{Marker locations on Chr 10}
#'    \item{1}{Marker locations on Chr 11}
#'    \item{1}{Marker locations on Chr 12}
#'    \item{1}{Marker locations on Chr 13}
#'    \item{1}{Marker locations on Chr 14}
#'    \item{1}{Marker locations on Chr 15}
#'    \item{1}{Marker locations on Chr 16}
#'    \item{1}{Marker locations on Chr 17}
#'    \item{1}{Marker locations on Chr 18}
#'    \item{1}{Marker locations on Chr 19}
#'    \item{1}{Marker locations on Chr X}
#' }
"map"


#' Phenotype values for one phenotype.
#' 
#' @format A data.frame with 378 rows and 1 column:
#' \describe{
#'    \item{phenotype}{A numeric phenotype.}
#' }
"pheno"
