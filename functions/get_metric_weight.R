get_metric_weight <- function(weight){
  
  weight <- weight %>% 
    str_extract("[0-9]+(?= lb)") %>% 
    as.numeric()
  
  metric_weight <- round(weight / 2.205, 2)
  
  return(metric_weight)
}

get_metric_weight <- Vectorize(get_metric_weight)