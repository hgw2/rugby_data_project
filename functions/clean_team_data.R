clean_team_data <- function(){

  files <- c()
  
  
  for (file in list.files("~/rugby_data_project/3_raw_data/team_data/")) {
    file_path <- paste("~/rugby_data_project/3_raw_data/team_data/", file, sep = "")
    files <- c(files, file_path)
  }
  
  complete_data <- NULL
  
  for (file in files) {
    part_data <- read_csv(file)
    
    names <- part_data %>% 
      select(-competition: -team) %>% 
      colnames()
    
    part_data <-  part_data  %>% 
      group_by(date, match) %>% 
      mutate(home_away = if_else(row_number() == 1, "home", "away"), .after = match) %>% 
      ungroup() %>% 
      pivot_longer(names,names_to = "stat", values_to = "values") %>% 
      mutate(season = as.character(season)) %>% 
      mutate(stat = recode(stat,
                           "tries" = "try_scored",
                           "carries_metres"  = "ball_carry_meters",
                           "runs" = "ball_carry" ,
                           "defenders_beaten"  = "beat_defender" ,
                           "clean_breaks" =  "line_break",
                           "turnovers_conceded" = "total_turnovers_conceded" ,
                           "points"  = "points_scored" ,
                           "tackles"  =  "tackle_made",
                           "missed_tackles" = "tackle_missed",
                           "turnover_won" = "total_turnovers_gained",
                           "conversion_goals" = "conversion_successful" ,
                           "penalty_goals"  = "penalty_goal_successful" ,
                           "drop_goals_converted" ="drop_kick_successful" ,
                           "lineouts_won"  = "lineout_won_own_throw", 
                           "red_cards" = "red_card" ,
                           "yellow_cards" = "yellow_card",
                           .default = stat
                           
      )) %>% 
      mutate(team = str_to_lower(team)) %>% 
      mutate(team = str_replace(team," ", "_")) %>% 
      mutate(match_id = paste(str_replace_all(as.character(date),"-", ""),
                              str_extract(match, "^[a-z0-9]{2}"),
                              "vs",
                              str_extract(match, "(?<=vs_)[a-z0-9]{2}"),
                              sep = "")
             , .before = competition) 
    
    
    complete_data <- bind_rows(complete_data, part_data)

  }
  
  dir.create("~/rugby_data_project/5_clean_data")
  if (file.exists("~/rugby_data_project/5_clean_data/team_data.csv")) {
  read_csv("~/rugby_data_project/5_clean_data/team_data.csv",
           col_types =
             cols(
               season = "c"
             )) %>% 
    bind_rows(complete_data) %>% 
    arrange(date, match) %>% 
    write_csv("~/rugby_data_project/5_clean_data/team_data.csv")
    } else {
  complete_data %>% 
    write_csv("~/rugby_data_project/5_clean_data/team_data.csv")
      }
  unlink("~/rugby_data_project/3_raw_data/team_data/", recursive = TRUE)

}