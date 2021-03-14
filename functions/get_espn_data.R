get_espn_data <- function(urls, country) {
  
    table <- c()
    dir.create("~/rugby_data_project/3_raw_data/temp/")
    dir.create("~/rugby_data_project/3_raw_data/espn/")
    
   
    for (webpage in urls){
      player <- get_player_info(webpage)
     
      name <- player %>% 
        pull(espn_no)
      
      file_path <- paste("~/rugby_data_project/3_raw_data/temp/", name, ".csv", sep = "")
      
  if(is_null(player)){

  } else { 
   
    player  %>% 
      write_csv(file_path)
    }
    
    }
}