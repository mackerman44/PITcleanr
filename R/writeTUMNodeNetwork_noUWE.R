#' @title Tumwater Node Network
#'
#' @description Create data.frame describing all the observation nodes in the Tumwater dam version of DABOM, including how they are related to one another. This function does not include the detection site UWE
#'
#' @author Kevin See
#'
#'
#' @import dplyr tibble stringr
#' @export
#' @return NULL
#' @examples writeTUMNodeNetwork_noUWE()

writeTUMNodeNetwork_noUWE = function() {
  bin_names = c('Peshastin',
                'Icicle',
                'Chiwaukum',
                'Chiwawa',
                'Nason',
                'LittleWenatchee',
                'WhiteRiver')
  bin_list = vector('list', length(bin_names))
  names(bin_list) = bin_names

  bin_list[['Peshastin']] = list('PES' =
                                   list('PES',
                                        'PEU'))

  bin_list[['Icicle']] = list('ICL' =
                                list('ICL',
                                     'LNF' =
                                       list('LNF',
                                            'LEAV'),
                                     'ICM' =
                                       list('ICM',
                                            'ICU')))

  bin_list[['Chiwaukum']] = list('CHW')

  bin_list[['Chiwawa']] = list('CHL' =
                                 list('CHL',
                                      'CHU'))

  bin_list[['Nason']] = list('NAL' =
                               list('NAL',
                                    'NAU'))

  bin_list[['LittleWenatchee']] = list('LWN')

  bin_list[['WhiteRiver']] = list('WTL')

  bin_all = list('TUM' =
                   list('TUM',
                        bin_list))

  site_df_init = tibble(SiteID = unlist(bin_all),
                        path = names(unlist(bin_all))) %>%
    mutate(path = stringr::str_replace(path,
                                       '[[:digit:]]$',
                                       '')) %>%
    rowwise() %>%
    mutate(path = ifelse(stringr::str_sub(path, start = -nchar(SiteID)) != SiteID,
                         paste(path, SiteID, sep = '.'),
                         path)) %>%
    ungroup()

  network_descrip = stringr::str_split(site_df_init$path,
                                       '\\.',
                                       simplify = T)
  colnames(network_descrip) = paste0('Step', 1:ncol(network_descrip))

  site_df = site_df_init %>%
    bind_cols(network_descrip %>%
                as.data.frame()) %>%
    tidyr::gather(brk, upstrm_site, matches('Step')) %>%
    mutate(upstrm_site = ifelse(upstrm_site == '', NA, upstrm_site)) %>%
    tidyr::spread(brk, upstrm_site,
                  fill = '') %>%
    mutate(SiteID = factor(SiteID,
                           levels = site_df_init$SiteID)) %>%
    arrange(SiteID)


  return(site_df)
}
