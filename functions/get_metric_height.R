get_metric_height <- function(height){
  
  feet <- height %>% 
    str_extract("[0-9]+(?= ft)") %>% 
    as.numeric()
  
  inches <- height %>% 
    str_extract("[0-9]+(?= in)") %>% 
    as.numeric()
  
  total_inches <- (feet * 12) + inches
  centimeters <- round(total_inches * 2.540051, 2)
  
  return(centimeters)
  
  
}

get_metric_height <- Vectorize(get_metric_height)