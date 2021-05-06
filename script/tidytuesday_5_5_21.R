### Me attempting to do Spatial Data 
### Date: 5/5/2021
### Richard Rachman
###################

## library

library("tidyverse")
library(here)
library(sf)
library(stars)
library(units)
library(raster)
library(mapview)
library(cubeview)

## data

#landsat_04_10_2000.tif

## plot
l = read_stars(here("data","data","landsat_04_10_2000.tif")) #read in the data
bands = c("Blue", "Green", "Red", "NIR", "SWIR1", "SWIR2") #name each one of the bands in the seperate pictures
l = st_set_dimensions(l, "band", values = bands)
names(l) = "reflectance"
#map out NDVI which is just red and NIR
red = l[,,,3, drop = TRUE]
nir = l[,,,4, drop = TRUE]
ndvi = (nir - red) / (nir + red)
names(ndvi) = "NDVI"
plot(ndvi, breaks = "equal", col = hcl.colors(11, "Spectral"))+
  ggsave(here("output", "NormalizedDifferenceVegIndex.JPEG"))
#reclassified to show high and low NDVI
l_rec = ndvi
l_rec[ndvi <= 0.2] = 0
l_rec[ndvi > 0.2] = 1
plot(l_rec, col = c("grey90", "darkgreen"))+
  ggsave(here("output", "NormalizedDifferenceVegIndexBinary.JPEG"))
