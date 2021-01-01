get_team_stats <- function(webpage){
  match <- str_extract(webpage, "[a-z0-9-]+[0-9]{8}") %>%
    str_replace_all("-", "_") %>%
    str_extract("[a-z0-9_]+(?=_at)")
  
  home_team <- match %>% 
    str_extract("[a-z0-9_]+(?=_vs)")  
  
  
  away_team <- match %>% 
    str_extract("(?<=vs_)[a-z0-9_]+") 
  
  webpage <- read_html(webpage)
  
  data <- webpage  %>% 
    html_nodes('div.key-stats') %>% 
    html_text()
  
  
  #Attack stats---- 
  possession <- data %>% 
    str_remove_all("[\"]") %>% 
    str_extract("(?<=Possession,)[0-9,.]+,") %>% 
    str_replace_all(",", " ") %>% 
    trimws()
  
  home_possession <- possession[1] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  away_possession <- possession[1] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  
  
  
  
  
  
  
  
  coversions_missed <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Conversions missed)") %>% 
    trimws()
  
  home_conversions_missed <- coversions_missed[3] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_conversions_missed <- coversions_missed[3] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  
  penalty_missed <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Penalty goals missed)") %>% 
    trimws()
  
  home_penalty_missed <- penalty_missed[3] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_penalty_missed <- penalty_missed[3] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  
  drop_goal_missed <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Drop goals missed)") %>% 
    trimws()
  
  home_drop_goal_missed <- drop_goal_missed[3] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_drop_goal_missed <- drop_goal_missed[3] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  rucks_won <- data %>% 
    str_remove_all("[\"]") %>% 
    str_extract("(?<=Rucks won,)[0-9,.]+,") %>% 
    str_replace_all(",", " ") %>% 
    trimws()
  
  home_rucks_won <- rucks_won[4] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  away_rucks_won <- rucks_won[4] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  
  rucks_lost <- data %>% 
    str_remove_all("[\"]") %>% 
    str_extract("(?<=Rucks lost,)[0-9,.]+,") %>% 
    str_replace_all(",", " ") %>% 
    trimws()
  
  home_rucks_lost <- rucks_lost[4] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  away_rucks_lost <- rucks_lost[4] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  
  
  mauls_won <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Mauls won)") %>% 
    trimws()
  
  home_mauls_won <- mauls_won[4] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_mauls_won <- mauls_won[4] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  
  
  scrum_won <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Scrums won)") %>% 
    trimws()
  
  home_scrum_won <- scrum_won[5] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_scrum_won <- scrum_won[5] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  scrum_lost <- data %>% 
    str_extract("[0-9]+ [0-9]+ (?=Scrums lost)") %>% 
    trimws()
  
  home_scrum_lost <- scrum_lost[5] %>% 
    str_extract("^[0-9.]+") %>% 
    as.numeric()
  
  away_scrum_lost <- scrum_lost[5] %>% 
    str_extract("[0-9.]+$") %>% 
    as.numeric()
  
  
  drop_goal_missed <- c(home_drop_goal_missed, away_drop_goal_missed)
  penalty_missed <- c(home_penalty_missed, away_penalty_missed)
  conversion_missed <- c(home_conversions_missed, away_conversions_missed)
  rucks_won <- c(home_rucks_won, away_rucks_won)
  rucks_lost <- c(home_rucks_lost, away_rucks_lost)
  mauls_won <- c(home_mauls_won,away_mauls_won)
  scrum_won <- c(home_scrum_won, away_scrum_won)
  scrum_lost <- c(home_scrum_lost, away_scrum_lost)
  team <- c(home_team,away_team)
  possession <- c(home_possession, away_possession)
  tibble(team, possession,drop_goal_missed,penalty_missed, conversion_missed, rucks_won, rucks_lost, mauls_won,scrum_won, scrum_lost )
}