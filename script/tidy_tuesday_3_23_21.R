### Me attempting to do TidyTeusday 
### Date: 3/23/2021
### Richard Rachman

#################################


### libraries

library(tidyverse)
library(tidytuesdayR)
library(here)
library(unvotes)
library(viridisLite)
library(hrbrthemes)
library(magick)

##git init
##git add README.md
##git commit -m "first commit"
##git branch -M main
##git remote add origin https://github.com/awanderingecologist/awanderingecologist_tidytuesday.git
##git push -u origin main




### data

last_tuesday()
tt_load("2021-03-23")


vlevels <- c("yes", "abstain", "no")

load("data-raw/UNVotes2021.RData")

unvotes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/unvotes.csv')
roll_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/roll_calls.csv')
issues <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/issues.csv')

view(unvotes)
view(roll_calls)
view(issues)


### script

votesum <- unvotes %>%
  group_by(vote) %>%
  tally()

votesum

x <- c("Abstain", "No", "Yes")
counts <- c(110893/1000, 65500/1000, 693544/1000)
df <- data.frame(x=x, counts=counts)
un<-image_read("https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/UN_emblem_blue.svg/512px-UN_emblem_blue.svg.png")

un

plt <- ggplot(df) + 
  geom_bar(aes(x=x, y=counts), 
           stat="identity")+
  theme_bw() +
  theme(strip.background = element_rect(fill = "white", color = "white"),
        legend.position="none",
        plot.title = element_text(size=20)) + 
  labs(y="Number of votes cast divided by 1000", x="How UN Members Voted", 
       title="How Do UN Member States Vote Overall?")+
  ggsave("plt.png")
unplot<-image_read("plt.png")
img<- c(unplot, un)
img<-image_scale(img)
out <- image_composite(unplot, un, offset = "+600+400")+
  ggsave(here("output","un_votes.JPEG"))
out
    