get_home_team_tbl <- function(webpage, headings){
 
  match <- str_extract(webpage, "[a-z0-9-]+[0-9]{8}") %>%
    str_replace_all("-", "_") %>%
    str_extract("[a-z0-9_]+(?=_at)")
  
  home_team <- match %>% 
    str_extract("[a-z0-9_]+(?=_vs)") 
  
  
  webpage <- read_html(webpage)
  
  table_home <- webpage %>% 
    html_nodes("table") %>% 
    .[1:5] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_home[[1]]
  
  home <- colnames(table)
  
  
  
  home_table <- table_home %>% 
    reduce(full_join, by = c(home[1], home[2]))
  
  names(home_table) <- c("position", "player", headings)
  
  home_table <- home_table %>% 
    mutate(team = home_team, .before = player) %>% 
    drop_na(position) %>% 
    mutate(across(headings, as.numeric))
  
  
  return(home_table)
}