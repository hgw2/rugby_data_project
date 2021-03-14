library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)
source.all("functions")

links <- c()

# England

england <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=1"


scrape_espn_data(england, "england")


# Scotland

scotland <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=2"

scrape_espn_data(scotland, "scotland")

# Ireland 
ireland<- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=3"

scrape_espn_data(ireland, "ireland")

# wales
wales <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=4"

scrape_espn_data(wales, "wales")


# South Africa
south_africa <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=5"

scrape_espn_data(south_africa, "south_africa")

# Australia
australia <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=6"

scrape_espn_data(australia, "australia")

# France
france <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=9"

scrape_espn_data(france, "france")

italy <- "http://en.espn.co.uk/scrum/rugby/player/caps.html?team=20"
scrape_espn_data(italy, "italy")
