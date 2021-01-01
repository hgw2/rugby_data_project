

links <- c()
# autumn nations
autumn_nations <- "https://www.rugbypass.com/autumn-nations-cup/matches/"

autumn_nations <- get_match_links(autumn_nations)

links <- c(links, autumn_nations)


#six nations
six_nations <- "https://www.rugbypass.com/six-nations/matches/"

six_nations <- get_match_links(six_nations)

links <- c(links, six_nations)

# rugby championship
rugby_championship <- "https://www.rugbypass.com/the-rugby-championship/matches/"

rugby_championship <- get_match_links(rugby_championship)

links <- c(links, rugby_championship)
#internationals
internationals_2019 <- "https://www.rugbypass.com/internationals/matches/2019/"

internationals_2019 <- get_match_links(internationals_2019)

links <- c(links, internationals_2019)
internationals_2020 <- "https://www.rugbypass.com/internationals/matches/2020/"

internationals_2020 <- get_match_links(internationals_2020)
links <- c(links, internationals_2020)


#premiership

premiership <- "https://www.rugbypass.com/premiership/matches/"

premiership <- get_match_links(premiership)

links <- c(links, premiership)
#premiership_cup

premiership_cup <- "https://www.rugbypass.com/premiership-cup/matches/"

premiership_cup <- get_match_links(premiership_cup)

links <- c(links, premiership_cup)

#Heineken cup
heineken <- "https://www.rugbypass.com/european-champions-cup/matches/"

heineken <- get_match_links(heineken)

links <- c(links, heineken)

#challenge cup
challenge_cup<- "https://www.rugbypass.com/challenge-cup/matches/2019-2020/"

challenge_cup <- get_match_links(challenge_cup)
links <- c(links, challenge_cup)

#pro 14
pro14<- "https://www.rugbypass.com/pro-14/matches/"

pro14 <- get_match_links(pro14)

links <- c(links, pro14)

#super rugby
super_rugby <- "https://www.rugbypass.com/super-rugby/matches/"

super_rugby<- get_match_links(super_rugby)

links <- c(links, super_rugby)

#super rugby aoteroa
super_rugby_aotearoa <- "https://www.rugbypass.com/super-rugby-aotearoa/matches/"

super_rugby_aotearoa<- get_match_links(super_rugby_aotearoa)

links <- c(links, super_rugby_aotearoa)
#mitre 10 cup 

mitre10<- "https://www.rugbypass.com/mitre-10-cup/matches/"

mitre10<- get_match_links(mitre10)

links <- c(links, mitre10)

#super rugby australia

super_rugby_a <- "https://www.rugbypass.com/super-rugby-australia/matches/"

super_rugby_a<- get_match_links(super_rugby_a)

links <- c(links, super_rugby_a)

#super rugby unlocked

super_rugby_un <- "https://www.rugbypass.com/super-rugby-unlocked/matches/"

super_rugby_un<- get_match_links(super_rugby_un)


links <- c(links, super_rugby_un)

#currie cup

crrie <- "https://www.rugbypass.com/currie-cup/matches/"

crrie <- get_match_links(crrie)

links <- c(links, crrie)

#world cup
world_cup <- "https://www.rugbypass.com/rugby-world-cup/matches/"

world_cup <- get_match_links(world_cup)

links <- c(links, world_cup)
  
links <- unique(links)

scrape_rugby_pass_data1(links)

