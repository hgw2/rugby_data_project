library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)
source.all("functions")

links <- c()
# autumn nations
autumn_nations <- "https://www.rugbypass.com/autumn-nations-cup/matches/"

autumn_nations <- get_rugby_pass_links(autumn_nations)

links <- c(links, autumn_nations)


#six nations
six_nations <- "https://www.rugbypass.com/six-nations/matches/"

six_nations <- get_rugby_pass_links(six_nations)

links <- c(links, six_nations)

 #rugby championship
rugby_championship <- "https://www.rugbypass.com/the-rugby-championship/matches/"

rugby_championship <- get_rugby_pass_links(rugby_championship)

links <- c(links, rugby_championship)
#internationals
internationals_2019 <- "https://www.rugbypass.com/internationals/matches/2019/"

internationals_2019 <- get_rugby_pass_links(internationals_2019)

links <- c(links, internationals_2019)
internationals_2020 <- "https://www.rugbypass.com/internationals/matches/2020/"

internationals_2020 <- get_rugby_pass_links(internationals_2020)
links <- c(links, internationals_2020)


#premiership

premiership <- "https://www.rugbypass.com/premiership/matches/"

premiership <- get_rugby_pass_links(premiership)

links <- c(links, premiership)
#premiership_cup

premiership_cup <- "https://www.rugbypass.com/premiership-cup/matches/"

premiership_cup <- get_rugby_pass_links(premiership_cup)

links <- c(links, premiership_cup)

#Heineken cup
heineken <- "https://www.rugbypass.com/european-champions-cup/matches/"

heineken <- get_rugby_pass_links(heineken)

links <- c(links, heineken)

#challenge cup
challenge_cup<- "https://www.rugbypass.com/challenge-cup/matches/2019-2020/"

challenge_cup <- get_rugby_pass_links(challenge_cup)
links <- c(links, challenge_cup)

#pro 14
pro14<- "https://www.rugbypass.com/pro-14/matches/"

pro14 <- get_rugby_pass_links(pro14)

links <- c(links, pro14)

#super rugby
super_rugby <- "https://www.rugbypass.com/super-rugby/matches/"

super_rugby<- get_rugby_pass_links(super_rugby)

links <- c(links, super_rugby)

#super rugby aoteroa
super_rugby_aotearoa <- "https://www.rugbypass.com/super-rugby-aotearoa/matches/"

super_rugby_aotearoa<- get_rugby_pass_links(super_rugby_aotearoa)

links <- c(links, super_rugby_aotearoa)
#mitre 10 cup 

mitre10<- "https://www.rugbypass.com/mitre-10-cup/matches/"

mitre10<- get_rugby_pass_links(mitre10)

links <- c(links, mitre10)

#super rugby australia

super_rugby_a <- "https://www.rugbypass.com/super-rugby-australia/matches/"

super_rugby_a<- get_rugby_pass_links(super_rugby_a)

links <- c(links, super_rugby_a)

#super rugby unlocked

super_rugby_un <- "https://www.rugbypass.com/super-rugby-unlocked/matches/"

super_rugby_un<- get_rugby_pass_links(super_rugby_un)


links <- c(links, super_rugby_un)

#currie cup

crrie <- "https://www.rugbypass.com/currie-cup/matches/"

crrie <- get_rugby_pass_links(crrie)

links <- c(links, crrie)

#world cup
world_cup <- "https://www.rugbypass.com/rugby-world-cup/matches/"

world_cup <- get_rugby_pass_links(world_cup)

links <- c(links, world_cup)

# top 14
top_14 <- "https://www.rugbypass.com/top-14/matches/"

top_14 <- get_rugby_pass_links(top_14)

links <- c(links, top_14)
  
links <- unique(links)

full_links <- tibble(
  link = links
) %>% 
  mutate(date =  dmy(str_extract(link, "[0-9]{8}"))) %>% 
  filter(date < Sys.Date()) %>% # remove future dates 
  pull(link)

if(file.exists("2_scrape_data/old_links.RData")){
  load("2_scrape_data/old_links.RData")
 
  links <- setdiff(full_links, old_links)
  
} else{
  links <- full_links
  
}
scrape_rugby_pass_data1(links)

 old_links <- full_links
 
  save(old_links, file = "2_scrape_data/old_links.RData")
