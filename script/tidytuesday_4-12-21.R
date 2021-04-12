###tidy_tuesday 
###4/10/21
###richard rachman

#######################

### library
library(tidyverse)
library(tidytuesdayR)
library(here)
library(viridis)
library(hrbrthemes)

### data

forest <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest.csv')
view(forest)
entity<- forest$entity
NorthAmerica<- c("Canada","Cuba","Mexico","United States")

forest1<- filter(forest, entity %in% NorthAmerica) %>%
  select(entity, year, net_forest_conversion) 


# North American countries
# Belize
# Canada
# Costa Rica
# Cuba
# Dominican Republic
# El Salvador
# Guatemala
# Honduras
# Jamaica
# Mexico
# Nicaragua
# Panama
# USA

### script

ggplot(forest1, aes(year, net_forest_conversion, label= entity, color= entity)) +
  geom_line((aes(colour = entity)))+ 
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Forest conversion by largest countries in NA") +
  theme_ipsum() +
  ylab("Scale of net forest conversion")+
  xlab("Year")+
  labs(caption = "Positive forest coversion suggestions forest expansion, 
       though data is incomplete for USA")+
  theme(legend.title = element_blank())





# Plot


