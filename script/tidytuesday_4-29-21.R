### Me attempting to do TidyTeusday 
### Date: 4/29/2021
### Richard Rachman

#################################


### libraries

library(tidyverse)
library(tidytuesdayR)
library(here)
library(textclean)
library(stringr)

### data

departures <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv')
head(departures)
View(departures)

departures<- departures%>%
  transform(exec_fullname= strsplit(exec_fullname, " "))%>%
  unnest(exec_fullname)
departures$exec_fullname<- str_trim(departures$exec_fullname)%>%
  strip(departures$exec_fullname)
view(departures)
departures<- departures%>%
  strip(departures$exec_fullname)
unnest(exec_fullname)
departures$exec_fullname<- str_trim(departures$exec_fullname)
view(departures)
departures$exec_fullname<- strip(departures$exec_fullname)
view(departures)       
departures<- departures %>% 
  mutate(selected = case_when(nchar(exec_fullname)>1 ~ exec_fullname))
view(departures)
departures$Selected <- sapply(seq_len(nrow(departures)),
                      function(i) departures[i,which(nchar(departures[i,-1]) > 1)[1] + 1] )
view(departures)
names<- departures$exec_fullname[nchar(departures$exec_fullname) > 2]
view(names)
??slice_max
df <- as.data.frame(names)
view(df)
names(df) <- c("number","times")
df$rank <- rank(-df$times,ties.method="min")
df <- df[order(df$rank,decreasing = F),]
df<- data.frame(count=sort(table(df), decreasing=TRUE))
view(df)
df$count.Freq <- as.numeric(as.character(df$count.Freq))
df$count.df<- as.character((as.character(df$count.df)))
df<- df%>%
  slice(1:10)
view(df)
df$count.df<- df$count.df%>%
  str_to_title()
view(df)

## plot

df%>%
  ggplot( aes(x=count.Freq, y=count.df)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() +
  ylab("Top 10 Most Common Known First, Middle, or Last names of CEOs
       That Left a S&P 1500 Firm from 2000-2018") +
  xlab("Count")+
  theme_bw()+
  ggsave(here("output","exectuivenames.JPEG"))
  
