### Me attempting to do TidyTeusday 
### Date: 4/20/2021
### Richard Rachman

#################################


### libraries

library(tidyverse)
library(tidytuesdayR)
library(here)
library(tidytext)
library(wordcloud2)
### data

netflix_titles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv')
view(netflix_titles)
descriptions<- netflix_titles$description
date_added<- netflix_titles$date_added
is.Date(date_added)
class(date_added)
date_added<-mdy(date_added)

# plot
count(word())


sent_word_counts <- netflix_titles$title %>%# only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them
sent_word_counts
