## Ggmap approach


mapbox_token <- read_lines('mapbox.token')

GDL <- get_googlemap(
                            center  = c(lon = -103.3738154, lat = 20.682964),
                            zoom    = 13, 
                            scale   = 2,
                            maptype ='terrain',
                            color   = 'color'
                            ) 
base <-  trips %>% 
  filter(
    # month(Inicio_del_viaje)   ==  9,
    # day(Inicio_del_viaje)     %in%  1:15,
    year(Inicio_del_viaje)    ==  2018
    # ,
    # hour(Inicio_del_viaje)   %in% 17,
    # minute(Inicio_del_viaje) %in% 30:59,
    # duration                  > 30
         ) %>%
  sample_n(1000)
# 
#   top_n(
#     n = 1000, 
#     wt = duration
#     )

base %>% 
  dim

# Mapdeck  ------------------------------------------------------------------

mapdeck(
  token = mapbox_token, 
  style = 'mapbox://styles/mapbox/dark-v9'
  # style = mapdeck_style('satellite')
      ) %>%
  add_arc(
    data = base
    , origin      = c("longitude_orig", 
                      "latitude_orig")
    , destination = c("longitude_dest", 
                      "latitude_dest")
    , stroke_from = "Origen_Id"
    , stroke_to   = "Destino_Id"
    , tooltip     = "info"
    , layer_id    = 'arclayer'
    , stroke_width = "stroke"
  )

# Density Plot ------------------------------------------------------------


dens_GDL <- ggmap(
  GDL, 
      extent = "device") + 
  geom_density2d(
    data = base, 
    aes(x = longitude_orig, 
        y = latitude_orig), 
    size = 0.3
                ) + 
  stat_density2d(
    data = d, 
    aes(x = longitude, 
        y = latitude, 
        fill = ..level.., 
        alpha = ..level..
        ), 
    size = 0.01, 
    bins = 16, 
    geom = "polygon"
                  ) + 
  scale_fill_gradient(
    low = "green", 
    high = "red"
                    ) + 
  scale_alpha(
    range = c(0, 0.3), 
    guide = FALSE
    ) +
  theme(
    axis.text.x  = element_blank(),
    axis.text.y  = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

dens_GDL

plotly::ggplotly(dens_GDL)

## This chunk of code can let us know what error there is 

# ggmap_credentials()
# geocode("Houston", output = "all")  




# Not in use 

# Map Plot ----------------------------------------------------------------
# 
# 

# p <- ggmap(GDL)
# 
# p <- p + 
#   geom_point(
#     data = d, 
#     aes(
#       x = longitude,
#       y = latitude
#     ),
#     size   = 5,
#     colour = 'red',
#     alpha  = .3
#   )
# 
# 
# p %>% 
#   ggplot_build()
