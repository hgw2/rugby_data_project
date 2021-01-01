get_tbl_headings <- function(webpage){
  webpage <- read_html(webpage)
  headings <- webpage %>% 
    html_nodes("table") %>% 
    .[11:15] %>% 
    html_table(fill = TRUE)
  
  headings <- headings%>% 
    reduce(bind_rows)
  
  
  headings <- pull(headings[2])
  
  headings <- str_to_lower(headings) %>% 
    str_replace_all(" ", "_")
  
  return(headings)
}

