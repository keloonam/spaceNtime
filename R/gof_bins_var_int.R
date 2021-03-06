#' Internal function to build gof bins at a single occasion
#'
#' @param censor right-censor cutoff
#' @param lambda estimate of lambda
#' @param n_bins number of bins to build
#'
#' @return returns a one row data frame
#' @export
#'
#' @examples gof_bins_var_int(censor, lambda, n_bins)
gof_bins_var_int <- function(censor, lambda, n_bins){
  # internal function to build bins at a single occasion
  
  cutoffs <- seq(0, censor, length.out = n_bins)
  
  out <- tibble(
    bin = 1:n_bins, 
    left = cutoffs, 
    right = lead(cutoffs),
    prob = exp_dens(left, right, lambda)
  ) %>%
    mutate(prob = tidyr::replace_na(prob, replace = 1 - sum(prob, na.rm = T)))
    
  return(out)
}
