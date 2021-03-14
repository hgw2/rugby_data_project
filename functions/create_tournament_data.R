scrape_rugby_pass_data1 <- function(urls) {

  # Create temp directory for overall stats
  dir.create("~/rugby_data_project/3_raw_data")
  dir.create("~/rugby_data_project/3_raw_data/player_data")
  dir.create("~/rugby_data_project/3_raw_data/team_data")
  for (webpage in urls) {
    
    skip_to_next <- FALSE
    
    tryCatch({

    


# Get the tournament name    
   tournament <- webpage %>% 
      str_extract("(?<=live/)[a-z0-9-]+") %>% 
      str_replace_all("-", "_")

   # get the season year
    season <- webpage %>% 
     str_extract("(?<=on-)[0-9]+/[0-9-]+") %>% 
     str_remove_all("[0-9]+/")
   
    # get the match
    match <- str_extract(webpage, "[a-z0-9-]+[0-9]{8}") %>%
      str_replace_all("-", "_") %>%
      str_extract("[a-z0-9_]+(?=_at)")
    
    home_team <- match %>% 
      str_extract("[a-z0-9_]+(?=_vs)") 
    
    away_team <- match %>% 
      str_extract("(?<=vs_)[a-z0-9_]+") 
    
    date <- str_extract(webpage, "[0-9]{8}")
    
    match_date <- date %>% 
      dmy() %>% 
      str_replace_all("-", "")
    
    date_match <- paste( match_date, match, sep = "_")

 
    # get home and team
    headings <- get_tbl_headings(webpage)

    home_table <- get_home_team_tbl(webpage, headings) %>%
      mutate(date = as.numeric(date), .before = position) %>%
      mutate(
        date = dmy(date),
        match = match, .after = date)%>% 
          mutate(
            competition = tournament, .before = date) %>% 
      mutate(
            season = season, .after = competition)
          
      

    away_table <- get_away_team_tbl(webpage, headings) %>%
      mutate(date = as.numeric(date), .before = position) %>%
      mutate(
        date = dmy(date),
        match = match, .after = date)%>% 
      mutate(
        competition = tournament, .before = date) %>% 
      mutate(
        season = season, .after = competition)
      

    full_table <- home_table %>%
      bind_rows(away_table)
    

  
    temp_home_file_path <- paste("3_raw_data/player_data/", match_date, "_", home_team,  ".csv", sep = "")
    
    home_table %>%
      write_csv(temp_home_file_path)
    
    
  
    temp_away_file_path <- paste("3_raw_data/player_data/", match_date, "_", away_team, ".csv", sep = "")
    
    away_table %>%

      write_csv(temp_away_file_path)
    

    
    # Get team stats ----
    summarised_team_stats <- full_table %>%
      select(-competition:-position, -player) %>%
      group_by(team) %>%
      summarise_all(sum)

   
    remaining_team_stats <- get_team_stats(webpage)

    full_team_stats <- summarised_team_stats %>%
      full_join(remaining_team_stats) %>%
      mutate(date = as.numeric(date), .before = team) %>%
      mutate(
        date = dmy(date),
        match = match, .after = date)%>% 
      mutate(
        competition = tournament, .before = date) %>% 
      mutate(
        season = season, .after = competition)



 





 
    temp_team_file_path <- paste("3_raw_data/team_data/", date_match, ".csv", sep = "")

    full_team_stats %>%
      write_csv(temp_team_file_path)
    
    }, error = function(e){ skip_to_next <<- TRUE })
    
   if(skip_to_next) { next }
    
  }
}
