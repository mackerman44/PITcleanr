#' @title LGR Node Network
#'
#' @description Create data.frame describing all the observation nodes in the Lower Granite dam version of DABOM, including how they are related to one another
#'
#' @author Kevin See
#'
#'
#' @import dplyr stringr
#' @return NULL
#' @examples writeLGRNodeNetwork()

writeLGRNodeNetwork = function() {

  bin_names = c('Clearwater',
                'SW_Washington',
                'NE_Oregon',
                'Imnaha',
                'Salmon')
  bin_list = vector('list', length(bin_names))
  names(bin_list) = bin_names

  bin_list[['Clearwater']] = list('Lapwai' = list('LAP' =
                                                    list('LAP',
                                                         'MIS',
                                                         'SWT' =
                                                           list('SWT',
                                                                'WEB'))),
                                  'Potlatch' = list('JUL' =
                                                      list('JUL',
                                                           'KHS' =
                                                             list('KHS',
                                                                  'LBEARC',
                                                                  'BIGBEC'),
                                                           'HLM' =
                                                             list('HLM',
                                                                  'POTRWF',
                                                                  'POTREF'),
                                                           'PCM')),
                                  'Lolo' = list('LC1' =
                                                  list('LC1', 'LC2')),
                                  'Lochsa' = list('LRL' =
                                                    list('LRL',
                                                         'LRU' =
                                                           list('LRU',
                                                                'FISTRP'))),
                                   'SFClearwater' = list('SC1' =
                                                          list('SC1',
                                                               'SC2' =
                                                                 list('SC2',
                                                                      'CROTRP',
                                                                      'CRT',
                                                                      'REDTRP',
                                                                      'REDR',
                                                                      'RRT'))),
                                  'ClearCreek' = list('CLC' =
                                                        list('CLC',
                                                             'KOOS')),
                                  'Selway' = list('SW1' =
                                                    list('SW1',
                                                         'SW2'))
                                  )

  bin_list[['SW_Washington']] = list('Tucannon' =
                                       list('LTR' =
                                              list('LTR',
                                                   'MTR' =
                                                     list('MTR',
                                                          'UTR' =
                                                            list('UTR',
                                                                 'TUCH',
                                                                 'TFH')))),
                                     'Almota' = list('ALMOTC'),
                                     'Alpowa' = list('ALPOWC'),
                                     'Penawawa' = list('PENAWC'),
                                     'TenMileCreek' = list('TENMC2'),
                                     'Asotin' = list('ACM' =
                                                       list('ACM',
                                                            'GEORGC',
                                                            'ASOTIC' =
                                                              list('ASOTIC',
                                                                   'ACB' =
                                                                     list('ACB',
                                                                          'AFC',
                                                                          'CCA')))))

  bin_list[['NE_Oregon']] = list('JosephCreek' =
                                   list('JOC' =
                                          list('JOC',
                                               'JOSEPC')),
                                 'GrandeRonde' =
                                   list('UpperGrandeRonde' =
                                          list('UGR' =
                                                 list('UGR',
                                                      'CCW' =
                                                        list('CCW',
                                                             'CATHEW'),
                                                      'UGS' =
                                                        list('UGS',
                                                             'GRANDW')))),
                                 'Wallowa' =
                                   list('WR1' =
                                          list('WR1',
                                               'BCANF',
                                               'WR2' =
                                                 list('WR2',
                                                      'LOSTIW',
                                                      'WALH'))),
                                 'LookingGlass' =
                                   list('LOOKGC',
                                        'LOOH'),
                                 'Wenaha' = list('WEN')
                                 )

  bin_list[['Imnaha']] = list('CowCreek' =
                                list('COC'),
                              'ImnahaRiver' =
                                list('IR1' =
                                       list('IR1',
                                            'IR2' =
                                              list('IR2',
                                                   'CMP',
                                                   'BSC',
                                                   'LSHEEF',
                                                   'HORS3C',
                                                   'IR3' =
                                                     list('IR3',
                                                          'CZY',
                                                          'FREEZC',
                                                          'MAHOGC',
                                                          'IR4' =
                                                            list('IR4',
                                                                 'IML' =
                                                                   list('IML',
                                                                        'IMNAHW' =
                                                                          list('IMNAHW',
                                                                               'IR5' =
                                                                                 list('IR5',
                                                                                      'GUMBTC',
                                                                                      'DRY2C')))))))))

  bin_list[['Salmon']] = list('RapidRiver' =
                                list('RAPH',
                                     'RPDTRP'),
                              'SFSalmon' =
                                list('SFG' =
                                       list('SFG',
                                            'ZEN' =
                                              list('ZEN',
                                                   'LAKEC'),
                                            'KRS' =
                                              list('KRS',
                                                   'STR'),
                                            'ESS' =
                                              list('ESS',
                                                   'JOHNSC',
                                                   'YPP'))),
                              'BigCreek' =
                                list('TAY' =
                                       list('TAY',
                                            'BIG2C')),
                              'Panther' = list('PCA'),
                              'NFSalmon' =
                                list('NFS'),
                              'CarmenCreek' =
                                list('CRC'),
                              'Lemhi' =
                                list('LLR' =
                                       list('LLR',
                                            'AGC',
                                            'KEN',
                                            'HYC',
                                            'WPC' =
                                              list('WPC',
                                                   'WIMPYC'),
                                            'BHC',
                                            'LRW' =
                                              list('LRW',
                                                   'LLS',
                                                   'BTL' =
                                                     list('BTL',
                                                          'BTM' =
                                                            list('BTM',
                                                                 'BTU')),
                                                   'LCL',
                                                   'LB8',
                                                   'LBS',
                                                   'CAC',
                                                   '18M',
                                                   'HEC'))),
                              'UpperSalmon' = list('USE' =
                                                     list('USE',
                                                          'USI' =
                                                            list('USI',
                                                                 'VC2' =
                                                                   list('VC2',
                                                                        'VC1'),
                                                                 'YFK' =
                                                                   list('YFK',
                                                                        'YANKFK',
                                                                        'CEY'),
                                                                 'STL' =
                                                                   list('STL',
                                                                        'SAWT'),
                                                                 'SALEFT',
                                                                 'PAHH',
                                                                 'RFL'))),
                              'BearValley' = list('BRC')
                              )

  bin_all = list('GRA' =
                   list('GRA',
                        'Clearwater' = bin_list[['Clearwater']],
                        'SW_Washington' = bin_list[['SW_Washington']],
                        'NE_Oregon' = bin_list[['NE_Oregon']],
                        'Imnaha' = bin_list[['Imnaha']],
                        'Salmon' = bin_list[['Salmon']]))

  site_df_init = tibble(SiteID = unlist(bin_all),
                        path = names(unlist(bin_all))) %>%
    mutate(path = stringr::str_replace(path,
                                       '[[:digit:]]$',
                                       ''),
           path = stringr::str_replace(path,
                                       'SC$',
                                       'SC1'),
           path = stringr::str_replace(path,
                                       'USI1',
                                       'USI'),
           path = stringr::str_replace(path,
                                       'LRW1',
                                       'LRW'),
           path = ifelse(SiteID %in% c('IR1', 'IR4'),
                         stringr::str_replace(path,
                                              'IR$',
                                              SiteID),
                         path)) %>%
    mutate(path = ifelse(stringr::str_sub(path, start = -nchar(SiteID)) != SiteID,
                         paste(path, SiteID, sep = '.'),
                         path))

  network_descrip = stringr::str_split(site_df_init$path,
                                       '\\.',
                                       simplify = T)
  colnames(network_descrip) = paste0('Step', 1:ncol(network_descrip))

  site_df = site_df_init %>%
    bind_cols(network_descrip %>%
                as.data.frame()) %>%
    mutate(across(starts_with('Step'),
                  as.character)) %>%
    mutate(SiteID = factor(SiteID,
                           levels = unique(site_df_init$SiteID))) %>%
    arrange(SiteID)


  return(site_df)
}
