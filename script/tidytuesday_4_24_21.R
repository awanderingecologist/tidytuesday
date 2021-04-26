### Me attempting to do TidyTeusday 
### Date: 4/24/2021
### Richard Rachman
###################

### libraries
library(tidyverse)
library(tidytuesdayR)
library(here)
library(sf)
library(terrainr)
library(progressr)
library(raster)

### data

sf_trees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv')
view(sf_trees)

#remove NAs

sf_trees<- sf_trees%>%
  filter(complete.cases(.))

#seperate species

sf_trees<- sf_trees%>%
  transform(species= strsplit(species, "::"))%>%
  unnest(species)
sf_trees$species<- str_trim(sf_trees$species)
view(sf_trees)

#isolate Quercus agrifolia

oaks<- sf_trees%>%
  filter(species== "Quercus agrifolia")
view(oaks)

#San Fran bounding box

# -122.3557214778,37.6916581916 
# -122.5191367945,37.6940965315 
# -122.5163163331,37.8123588781 
# -122.3529010164,37.8099244323 
# -122.3557214778,37.6916581916

handlers("progress")

#make a bounding box

simulated_data <- data.frame(id = seq(1, 100, 1),
                             lat = runif(100, 37.6916581916 , 37.8123588781), 
                             lng = runif(100, -122.5191367945, -122.3529010164))
#manipulate the data to in both the bounding box and oaks to be single column of coordinates

simulated_data <- st_as_sf(simulated_data, coords = c("lng", "lat"))
oaks<- st_as_sf(oaks, coords = c("longitude", "latitude"))
view(oaks)
#give the oaks a coordinate system
oaks<-st_set_crs(oaks, 4326)

#give the bounding box a coordinate system
simulated_data <- st_set_crs(simulated_data, 4326)

#make the ortho map

with_progress( # Only needed if you're using progressr
  output_tiles <- get_tiles(simulated_data,
                            services = c("elevation", "ortho"),
                            resolution = 90 # pixel side length in meters
  )
)
raster::plot(raster::raster(output_tiles[["elevation"]][[1]]))

#merge the oaks and ortho layers


vector_overlay <- vector_to_overlay(
  oaks,
  output_tiles[["ortho"]]
)

vector_overlay <- combine_overlays(
  output_tiles[["ortho"]],
  vector_overlay
)

raster::plotRGB(raster::stack(vector_overlay))

# map

ggplot() + 
  geom_spatial_rgb(data = output_tiles[["ortho"]],
                   aes(x = x, y = y, r = red, g = green, b = blue)) + 
  geom_sf(data = oaks)+
  xlab("Longitude")+
  ylab("Latitude")+
  labs(title = "Coast Live Oaks of San Francisco")+
  ggsave(here("output","oaks.JPEG"))

