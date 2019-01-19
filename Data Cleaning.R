source('libraries.R')

data <- read_rds('mi_bici_data.Rds')

stations <- read_csv('stations_name.csv')


trips <- data %>%  
  mutate(age      = (2018-born_year),
         duration =  difftime(Fin_del_viaje,
                              Inicio_del_viaje,
                              units = 'mins')
         )


trips %<>% 
  left_join(stations %>% 
              select_all(~str_c(.,'_orig')), 
            by = c('Origen_Id' = 'id_orig')
            ) %>% 
  left_join(stations %>% 
              select_all(~str_c(.,'_dest')),
            by = c('Destino_Id' = 'id_dest')
            )

