combine_temp <- function(country){
  files <- c()
  
  for (file in list.files("3_raw_data/temp/")) {
    file_path <- paste("3_raw_data/temp/", file, sep = "")
    files <- c(files, file_path)
  }
  
  complete_data <- NULL
  for (file in files) {
    part_data <- read_csv(file,
                          col_types =
                            cols(
                              birth_date = "c"))
    complete_data <- bind_rows(complete_data, part_data)
    
  }
  
  
  
  file_path <-paste("3_raw_data/espn/", country, ".csv", sep = "")
  
  if (is_null(complete_data)){
    
  } else{
  complete_data %>% 
    write_csv(file_path)
  }
  

unlink("3_raw_data/temp/", recursive = TRUE) 
}