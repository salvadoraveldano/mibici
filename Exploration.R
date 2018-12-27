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
  mutate(f = STATION_A-STATION_B) %>% 
  filter(
    f != 0,
    n > 88,
    WDAY %in% 1:5
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
  # facet_wrap(vars(WDAY)) +
  theme(
    axis.text.x = element_text(angle = 0)
  ) + 
  coord_flip()

plota

plotly::ggplotly(plota)
