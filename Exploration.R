# Exploratory Data 

trips <- oct18 %>% 
  group_by(
    WDAY      = wday(Inicio_del_viaje, week_start = 1),
    STATION_A = str_sub(obcn_orig,-3,-1) %>% 
      as.numeric(),
    STATION_B = str_sub(obcn_dest, -3,-1) %>% 
      as.numeric()
    ) %>% 
  summarise(n = n()) %>% 
  ungroup()


plota <- trips %>%
  mutate(f = STATION_A-STATION_B,
         STATION_A  = STATION_A %>% 
           as.factor(),
         STATION_B  = STATION_B %>% 
           as.factor()) %>% 
  filter(
    f != 0,
    n > 1,
    WDAY %in% 1:7
    ) %>% 
  mutate_at(vars(contains('STATION')),funs(str_squish(.))) %>% 
  ggplot(
    aes(
      x = STATION_A,
      y = STATION_B,
      fill = n
    )
  ) + 
  geom_tile() +
  scale_x_discrete(limits = seq(1,190,1)) +
  scale_y_discrete(limits = seq(1,190,1)) +
  scale_fill_viridis_c() +
  # facet_wrap(vars(WDAY)) +
  theme(
    axis.text.x = element_text(angle = 0)
  ) + 
  coord_flip()

plota


plotly::ggplotly(plota)
