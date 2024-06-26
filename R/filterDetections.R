#' @title Determine Detections to Keep
#'
#' @description After determining the direction of movement using `addDirection()`,
#' this function provides some indication of whether each detection
#' should be kept for an analysis analyzing movement in a single direction
#'
#' @author Kevin See
#'
#' @inheritParams addDirection
#' @param max_obs_date Character string in the format "YYYYMMDD". If included, the output will suggest that observations after this date should be deleted.
#'
#' @import dplyr tidyr lubridate purrr progress
#' @export
#' @return a tibble
#' @examples filterDetections()

filterDetections = function(compress_obs = NULL,
                            parent_child = NULL,
                            max_obs_date = NULL) {

  stopifnot(!is.null(compress_obs),
            !is.null(parent_child))

  obs_direct = addDirection(compress_obs = compress_obs,
                            parent_child = parent_child)

  if(is.null(max_obs_date)) {
    max_obs_date = (max(obs_direct$max_det, na.rm = T) + lubridate::days(1)) %>%
      format("%Y%m%d") %>%
      as.character()
  }

  # to add a progress bar for the following map function
  pb <- progress::progress_bar$new(format = "[:bar] :current/:total (:percent) remaining: :eta",
                                   total = n_distinct(obs_direct$tag_code),
                                   show_after = 2)

  keep_obs = obs_direct %>%
    group_by(tag_code) %>%
    tidyr::nest() %>%
    mutate(proc = purrr::map(data,
                             .f = purrr::safely(function(x) {
                               pb$tick()

                               if(sum(x$direction %in% c("backward", "unknown")) == 0) {
                                 x %>%
                                   mutate(auto_keep_obs = if_else(min_det <= lubridate::ymd(max_obs_date),
                                                                  T, F),
                                          user_keep_obs = if_else(min_det <= lubridate::ymd(max_obs_date),
                                                                  T, F)) %>%
                                   return()
                               } else {
                                 spwn_loc = x %>%
                                   filter(slot == max(slot[direction %in% c("start",
                                                                            "forward",
                                                                            "unknown") &
                                                             min_det <= lubridate::ymd(max_obs_date)]))

                                 if(nrow(spwn_loc) == 0) {
                                   x %>%
                                     mutate(auto_keep_obs = if_else(min_det <= lubridate::ymd(max_obs_date),
                                                                    T, F),
                                            user_keep_obs = if_else(min_det <= lubridate::ymd(max_obs_date),
                                                                    T, F)) %>%
                                     return()
                                 } else {


                                   # see if tag was seen further upstream but along the same path
                                   spwn_loc = x %>%
                                     filter(min_det <= lubridate::ymd(max_obs_date)) %>%
                                     filter(stringr::str_detect(path, spwn_loc$node)) %>%
                                     filter(node_order == max(node_order)) %>%
                                     filter(slot == max(slot))


                                   x %>%
                                     group_by(node) %>%
                                     mutate(max_slot = max(1, slot[slot <= spwn_loc$slot])) %>%
                                     ungroup() %>%
                                     rowwise() %>%
                                     mutate(in_spawn_path = if_else(stringr::str_detect(spwn_loc$path, paste0(" ", node)) |
                                                                      stringr::str_detect(spwn_loc$path, paste0("^", node)),
                                                                    T, F)) %>%
                                     # select(-travel_time, -start_date) %>%
                                     mutate(auto_keep_obs = if_else(((in_spawn_path & slot == max_slot) | direction == "start") &
                                                                      min_det <= lubridate::ymd(max_obs_date),
                                                                    T, F),
                                            user_keep_obs = NA) %>%
                                     select(-max_slot, - in_spawn_path) %>%
                                     ungroup() %>%
                                     return()
                                 }
                               }
                             },
                             otherwise = NULL))) %>%
    ungroup()

  # test for errors
  err_df = keep_obs %>%
    mutate(err = map(proc,
                     "error")) %>%
    mutate(not_err = map_lgl(err, is.null)) %>%
    filter(!not_err)
  if(nrow(err_df) > 0) {
    cat(paste('Problem with', nrow(err_df), 'tag(s)'))
    return(err_df)
  } else {

    keep_obs %>%
      mutate(res = map(proc,
                       "result")) %>%
      mutate(res = map(res,
                       .f = function(x) {
                         if(sum(is.na(x$user_keep_obs)) == 0) {
                           return(x)
                         } else {
                           same_nodes = x %>%
                             summarise(keep_nodes = list(sort(unique(node[auto_keep_obs]))),
                                       all_nodes = list(sort(unique(node)))) %>%
                             mutate(same_nodes = map2_lgl(keep_nodes,
                                                          all_nodes,
                                                          .f = function(x, y) {
                                                            identical(x, y)
                                                          })) %>%
                             pull(same_nodes)
                           if(!same_nodes) {
                             return(x)
                           } else {
                             x %>%
                               mutate(user_keep_obs = auto_keep_obs) %>%
                               return()
                           }
                         }
                       })) %>%
      select(-c(data:proc)) %>%
      tidyr::unnest(res) %>%
      return()
  }

}
