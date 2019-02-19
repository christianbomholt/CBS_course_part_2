setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(leaflet)

shipping <- read_csv("../data/output_daily_ship_location.csv")

shipping %>% head
n = 100000

sub_ship <- shipping %>% mutate(lat = lat_start, lon = lon_start) %>% 
  select(lat,lon) %>% head(n)

leaflet(sub_ship) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)

shipping %>% select(lat_end,lon_end,port_city_name) %>% unique() %>% dim


# shipping %>% filter(in_port) %>% group_by(callsign) %>% 
#   arrange(date) %>% 
#   mutate(from_port = lag(port_city_name)) %>%
#   filter(!is.na(from_port)) %>% 
#   mutate(route = paste(from_port,port_city_name,sep="-")) %>% 
#   filter(port_city_name!=from_port) %>% 
#   select(callsign,date,from_port,port_city_name,route) %>% 
#   filter(callsign=="OXRA6")

shipping %>% group_by(callsign) %>% 
  arrange(date) %>% 
  mutate(from_port = lag(port_city_name)) %>%
  filter(!is.na(from_port)) %>% 
  mutate(route = paste(from_port,port_city_name,sep="-")) %>% 
  filter(port_city_name!=from_port) %>% 
  select(callsign,date,from_port,port_city_name,route) %>% 
  filter(callsign=="OXRA6")



shipping[shipping$callsign=="OXRA6",] %>% arrange(date) %>% 
select(callsign,date,port_city_name,in_port)

shipping$port_city_name %>% unique() %>% length

# save(shipping, file = "../data/shipping.rdata")

ships  <- read_csv("../data/output_ships.csv")
deaths <- read_csv("../data/output_deaths.csv")
cities <- read_csv("../data/output_cities.csv")


greenLeafIcon <- makeIcon(
  iconUrl = "https://static.thenounproject.com/png/368069-200.png",
  iconWidth = 45, iconHeight = 45,
  iconAnchorX = 5, iconAnchorY = 5)

cities %>%
  filter(!is.na(id)) %>% 
  select(lat,lon,city) %>% 
leaflet() %>% addTiles() %>% addMarkers(~lon,~lat,icon = greenLeafIcon,
                                        popup = ~city, label = ~city)
