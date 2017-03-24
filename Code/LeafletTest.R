library(leaflet)

m <- leaflet() %>% 
  addTiles() %>% # Add openstreetmap map tiles
  fitBounds(
    lng1 = ne_boundary$long[1],
    lng2 = ne_boundary$long[2],
    lat1 = ne_boundary$lat[1],
    lat2 = ne_boundary$lat[2]
  )

m
