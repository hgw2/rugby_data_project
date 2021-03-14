clean_espn_data <- function()
{ 
  if (length(list.files("~/rugby_data_project/3_raw_data/espn/")) == 0){
    
  }else{
    
    files <- c()
    
    for(file in list.files("~/rugby_data_project/3_raw_data/cap_nos/")){
      file_path <- paste("~/rugby_data_project/3_raw_data/cap_nos/", file, sep = "")
      files <- c(files, file_path)
    }
    
    caps_data <- NULL
    
    for (file in files) {
      part_data <- read_csv(file)
      
      caps_data <- bind_rows(caps_data, part_data)
    } 
    files <- c()
    
    for(file in list.files("~/rugby_data_project/3_raw_data/espn/")){
      file_path <- paste("~/rugby_data_project/3_raw_data/espn/", file, sep = "")
      files <- c(files, file_path)
    }
    
    player_data <- NULL
    
    for (file in files) {
      part_data <- read_csv(file)
      
      player_data <- bind_rows(player_data, part_data)
    } 
    
    
    
    full_player_info <- caps_data %>% 
      inner_join(player_data)  %>% 
      mutate(birth_date = str_remove(birth_date, "circa ")) %>% 
      
      # Get Birth dates if there is only month and year
      mutate(birth_date = case_when(
        str_detect(birth_date, "[A-z0-9 ]+, [0-9]{4}") ~ mdy(birth_date),
        str_detect(birth_date, "[A-z]+ [0-9]{4}") ~ myd(birth_date, truncated = 1),
        TRUE ~ ymd(birth_date, truncated = 2))) %>% 
      mutate(birth_location = coalesce(birth_location,"Not Available")) %>%
      mutate(birth_location = str_replace(birth_location, "[^a-z]\\?", "Not Available")) %>% 
      mutate(birth_location = str_remove(birth_location, "\\?")) %>% 
      mutate(birth_location = str_remove(birth_location, "date unknown,")) %>%
      mutate(birth_location =str_squish(birth_location))
    
    full_player_info <- cSplit(full_player_info, 'clubs', ',') %>% 
      mutate(weight = get_metric_weight(weight),
             height = get_metric_height(height)) %>% 
      mutate(clubs_1 = coalesce(clubs_1, "No club")) 
    
    
    full_player_info <- full_player_info %>% 
      pivot_longer(cols = clubs_1:rev(names(full_player_info))[1],
                   names_to = "club_no",
                   values_to = "club") %>% 
      drop_na(club) %>% 
      mutate(club_no = str_remove(club_no, "clubs_"),
             club_no = as.numeric(club_no))
    
    
    
    if(file.exists("~/rugby_data_project/5_clean_data/espn_player_info.csv")){
      existing <- read_csv("~/rugby_data_project/5_clean_data/espn_player_info.csv")
      complete <-  existing %>% 
        bind_rows(full_player_info)
      
      complete %>% 
        write_csv("~/rugby_data_project/5_clean_data/espn_player_info.csv")
    } else {
      full_player_info  %>% 
        write_csv("~/rugby_data_project/5_clean_data/espn_player_info.csv")
      
    }
    
    
    
    
  }
  
  unlink("~/rugby_data_project/3_raw_data/espn/", recursive = TRUE)
  unlink("~/rugby_data_project/3_raw_data/cap_nos/", recursive = TRUE)
  
}