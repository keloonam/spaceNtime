#' Poisson goondess-of-fit tests for STE
#'
#' @param n_bins A vector of the number of bins to use in the chi squared test
#' @param lambda Calculated from the output of ste_estn_fn; EstN
#' @param df data frame prepped for ste_build_eh
#' @param deploy deployment data frame prepped for ste_build_eh
#' @param occ occasion data frame prepped for ste_build_eh
#'
#' @return returns a summary of the goodness-of-fit tests and the chi_squared results for each test
#' @export
#'
#' @examples pois_gof_STE(n_bins, lambda, df, deploy, occ)
pois_gof_ste <- function(n_bins, lambda, df, deploy, occ){
  
  #ste_calc_toevent line 67
  effort <- effort_fn(deploy, occ)
  
  ss <- lcd_fn(occ)
  
  if(ss == 0){
    warning("Occasions are not evenly spaced, so ste_calc_toevent must go the slow 
            route")
    # Find sampling occasions where counts exist
    # This captures any count within the occasion. Later, I take only the first
    count_at_occ <- df %>%
      filter(count > 0) %>%
      left_join(effort, .,  by = "cam") %>%
      filter(datetime %within% int) %>%
      # Take only the first at each camera at each occasion
      distinct(occ, cam, .keep_all = T) %>%
      select(occ, cam, count)
    
  } else {
    
    # Do it with rounding instead of intervals!!! 
    count_at_occ <- df %>%
      filter(count > 0) %>%
      # round down to the nearest interval
      mutate(timefromfirst = as.numeric(datetime) - as.numeric(min(effort$start)),
             nearest = plyr::round_any(timefromfirst, ss, f = floor),
             nearestpos = as.POSIXct(nearest, 
                                     origin = min(effort$start), 
                                     tz = lubridate::tz(effort$start))
      ) %>%
      # Join by the start time of that interval
      left_join(., effort, by = c("nearestpos" = "start", "cam")) %>%
      # But then keep only if within the end date of that interval
      filter(datetime <= end) %>% 
      select(occ, cam, count) %>%
      # Only keep the first one at each camera on each occasion
      distinct(occ, cam, .keep_all = T)
  }
  
  tmp <- effort %>%
    # Randomly order cameras at each occasion
    group_by(occ) %>% 
    sample_n(n()) %>%
    
    # Join up our counts
    left_join(., count_at_occ, by = c("occ", "cam")) %>%
    mutate(count = tidyr::replace_na(count, 0))
  
  tmp2 <- purrr::map(n_bins, pois_gof_test, count = tmp$count, lambda = lambda)
  
  out <- list(
    summary = bind_rows(purrr::map(
      .x = tmp2, 
      .f = function(x) x$summary
    )),
    chi_sq_tables = purrr::map(
      .x = tmp2,
      .f = function(x) x$exp_obs
    )
  )
  
  return(out)
  
}
