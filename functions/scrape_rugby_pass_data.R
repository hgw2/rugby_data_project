scrape_rugby_pass_data <- function(urls) {

  tournaments <- c()
  
  for (webpage in urls) {
    
    skip_to_next <- FALSE
    
    tryCatch({

    # Create temp directory for overall stats
    dir.create("2_data/temp_player")
    dir.create("2_data/temp_team")

    # Create tournament directory
    
   tournament <- webpage %>% 
      str_extract("(?<=live/)[a-z0-9-]+") %>% 
      str_replace_all("-", "_")
  
    season <- webpage %>% 
     str_extract("(?<=on-)[0-9]+/[0-9-]+") %>% 
     str_remove_all("[0-9]+/")
   
    
   tournament_dir_path <- paste("2_data/", tournament, sep = "")
    dir.create(tournament_dir_path)
    
    season_dir_path <- paste("2_data/", tournament, "/", season, sep = "")
    dir.create(season_dir_path)

    # Create tournament temp folder team and player for overall tournament stats
    tournament_temp_player_dir_path <- paste("2_data/", tournament, "/temp_player", sep = "")
    dir.create(tournament_temp_player_dir_path)


    tournament_temp_team_dir_path <- paste("2_data/", tournament, "/temp_team", sep = "")
    dir.create(tournament_temp_team_dir_path)

    # get match and date from url
    match <- str_extract(webpage, "[a-z0-9-]+[0-9]{8}") %>%
      str_replace_all("-", "_") %>%
      str_extract("[a-z0-9_]+(?=_at)")
    
    date <- str_extract(webpage, "[0-9]{8}")
    
    match_date <- date %>% 
      dmy() %>% 
      str_replace_all("-", "")
    
    date_match <- paste( match_date, match, sep = "_")


    # create match directories
    match_dir_path <- paste("2_data/", tournament, "/", season, "/", date_match, sep = "")
   
    dir.create(match_dir_path)
 
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
      

    player_csv_path <- paste("2_data/", tournament, "/", season, "/", date_match,"/", date_match, "_player_stats.csv", sep = "")
    team_csv_path <- paste("2_data/", tournament, "/", season, "/", date_match, "/", date_match, "_team_stats.csv", sep = "")

    full_table <- home_table %>%
      bind_rows(away_table)
    
    home_team <- get_team(home_table)
    home_file_path <- paste("2_data/", tournament, "/temp_player/",match_date, "_", home_team, ".csv", sep = "")
    temp_home_file_path <- paste("2_data/temp_player/", match_date, "_", home_team,  ".csv", sep = "")
    
    home_table %>%
      write_csv(home_file_path) %>%
      write_csv(temp_home_file_path)
    
    away_team <- get_team(away_table)
    
    away_file_path <- paste("2_data/", tournament, "/temp_player/", match_date, "_", away_team, ".csv", sep = "")
    temp_away_file_path <- paste("2_data/temp_player/", match_date, "_", away_team, ".csv", sep = "")
    
    away_table %>%
      write_csv(away_file_path) %>%
      write_csv(temp_away_file_path)
    

    
    # Get team stats ----
    summarised_team_stats <- full_table %>%
      select(-competition:-position, -player) %>%
      group_by(country) %>%
      summarise_all(sum)

   
    remaining_team_stats <- get_team_stats(webpage)

    full_team_stats <- summarised_team_stats %>%
      full_join(remaining_team_stats) %>%
      mutate(date = as.numeric(date), .before = country) %>%
      mutate(
        date = dmy(date),
        match = match, .after = date)%>% 
      mutate(
        competition = tournament, .before = date) %>% 
      mutate(
        season = season, .after = competition) %>% 
      write_csv(team_csv_path)



    full_table %>%
      write_csv(player_csv_path)





    team_file_path <- paste("2_data/", tournament, "/temp_team/", date_match, ".csv", sep = "")
    temp_team_file_path <- paste("2_data/temp_team/", date_match, ".csv", sep = "")

    full_team_stats %>%
      write_csv(team_file_path) %>%
      write_csv(temp_team_file_path)
    
    }, error = function(e){ skip_to_next <<- TRUE })
    
   if(skip_to_next) { next }
    
  }
}
