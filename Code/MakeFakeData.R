# Simulated Data


library(sp)
library(rgdal)
library(ggplot2)
library(maptools)
library(dplyr)
library(magrittr)
library(lubridate)

# Census tract data
# Source: https://www.census.gov/geo/maps-data/data/cbf/cbf_tracts.html
ne <- readOGR("./Data/CensusTract/", "cb_2015_31_tract_500k")

tmp <- spsample(ne, n = 1500, type = "stratified")
plot(tmp)

dates <- today() - days(1:100)

lightSample <- tmp@coords %>%
  as.data.frame() %>%
  set_names(c("long", "lat")) %>%
  mutate(order = sample(1:n(), size = n(), replace = F)) %>%
  arrange(order) %>%
  slice(1:1000)

lightSample$install.date <- rep(dates, each = 1000/length(dates))

save(dates, lightSample, file = "Data/FakeData.Rdata")
