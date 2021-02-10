library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)
source.all("functions")

links <- c()

# England

england <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=1"

england_caps <- get_cap_no(england, "England")

england <- get_espn_links(england)


links <- c(links, england)

# Scotland

scotland <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=2"

scotland_caps <- get_cap_no(scotland, "Scotland")

scotland <- get_espn_links(scotland)

links <- c(links, scotland)



full_links <- unique(links)

if(file.exists("2_scrape_data/espn_old_links.RData")){
  load("2_scrape_data/espn_old_links.RData")
  
  links <- setdiff(full_links, old_links)
  
} else{
  links <- full_links
  
}

get_espn_data(links)

old_links <- full_links

save(old_links, file = "2_scrape_data/espn_old_links.RData")