source('libraries.R')

theme_set(hrbrthemes::theme_ipsum(grid = ''))

stations <- read_csv('stations_name.csv')


oct18 <- read_csv('datos_abiertos_2018_10.csv', skip = 0) %>% 
  rename(bornyear = 4) %>% 
  mutate(age      = (2018-bornyear),
         duration =  difftime(Fin_del_viaje,
                              Inicio_del_viaje,
                              units = 'mins')
         )

oct18 %>%
  filter(duration %>% 
           between(0,50)) %>% 
  select(duration) %>% 
  unlist %>% 
  qplot


oct18 %>% 
  left_join(stations %>% 
              select_all(~str_c(.,'_orig')), 
            by = c('Origen_Id' = 'id_orig')
            ) %>% 
  left_join(stations %>% 
              select_all(~str_c(.,'_dest')),
            by = c('Destino_Id' = 'id_dest')
            ) %>% 
  sample_n(1) %>% 
  t
