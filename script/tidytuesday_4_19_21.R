### Me attempting to do TidyTeusday 
### Date: 4/21/2021
### Richard Rachman
###################

# library
library(tidyverse)
library(tidytuesdayR)
library(here)
library(ggmap)
library(sf)
library(ggrepel)
library(ggsn)
?norm


# data
tuesdata <- tidytuesdayR::tt_load(2021, week = 16)
post_offices$discontinued[is.na(post_offices$discontinued)] <- 0
post_offices <- tuesdata$post_offices%>%
  filter(orig_county=="Los Angeles")
post_offices$discontinued[is.na(post_offices$discontinued)] <- 0
view(post_offices)
post_offices<- post_offices%>%
  filter(discontinued==0)
 post_offices<- post_offices%>%
   select(gnis_name,latitude,longitude)
view(post_offices)

#script

ggmap(la_county)+
  geom_point(data = post_offices,
                           aes(x = longitude, y = latitude),
                           size = 2)+
  geom_label_repel(
    aes(longitude, latitude, label = gnis_name),
    data=post_offices,
    family = 'Times', 
    size = 3, 
    box.padding = 0.7, point.padding = 0.5,
    segment.color = 'grey50')+
  labs(title= "Post Offices of Los Angeles County", y= "Latitude",x="Longitude")+
  ggsave(here("output","postoffices_la.JPG"))
