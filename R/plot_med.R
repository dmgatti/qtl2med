#' Plot mediation results.
#' 
#' @param med data.frame (or tibble) containing the mediation results returned by \code{\link{mediate}}.
#' @param threshold floating point number indicating the number of standard deviations of the LOD above or below which genes will be labelled. Negative numbers suppress labels. Default = -1.
#' @return a mediation plot.
#' @export
plot_med = function(med, threshold = -1) {

  if(missing(med)) {
    warning("plot_med: med object was NULL. No plot produced.")
    return()
  }
  
  if(threshold > 0) {
    med = med %>% 
            mutate(lod_std = scale(lod))
  }
  
  ggplot(data = med, mapping = aes(x = start, y = lod)) +
    geom_point() +
    if(threshold > 0) {
      geom_label(aes(pos, lod, label = symbol), data = filter(med, lod_std < threshold | lod_std > threshold))
    }

}