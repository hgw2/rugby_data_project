get_espn_data <- function(urls) {
  
    table <- c()
    dir.create("3_raw_data/espn/")
    for (webpage in urls){
      player <- get_player_info(webpage)
      
      name <- player %>% 
        mutate(name = str_to_lower(name)) %>% 
        mutate(name = str_replace_all(name, " ", "_")) %>% 
        pull(name)
      
      file_path <- paste("3_raw_data/espn/", name, ".csv", sep = "")
      
    
   player  %>% 
      write_csv(file_path)
    }
}