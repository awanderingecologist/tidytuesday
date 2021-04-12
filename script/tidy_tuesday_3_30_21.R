### Me attempting to do TidyTeusday 
### Date: 3/23/2021
### Richard Rachman
###################

### libraries
library(tidyverse)
library(tidytuesdayR)
library(here)

### data
sephora <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/sephora.csv')
ulta <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/ulta.csv')
allCategories <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allCategories.csv')
allShades <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allShades.csv')
allNumbers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allNumbers.csv')

view(sephora)
view(ulta)
view(allCategories)
view(allShades)


view(allNumbers)


### script

ggplot(data=allNumbers, aes(x=lightness, group=brand, fill=hex)) +
  geom_density(adjust=1.5) +
  theme_ipsum() +
  facet_wrap(~brand) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    axis.ticks.x=element_blank()
  )+
  labs(title = 'The average lightness of various makeup brands', subtitle = 'Closer to zero is darker, closer to one is lighter')


