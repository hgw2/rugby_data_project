get_away_team_tbl <- function(webpage, headings){
  
  match <- str_extract(webpage, "[a-z0-9-]+[0-9]{8}") %>%
    str_replace_all("-", "_") %>%
    str_extract("[a-z0-9_]+(?=_at)")
  
  away_team <- match %>% 
    str_extract("(?<=vs_)[a-z0-9_]+")  
  
  
  
  webpage <- read_html(webpage)
  table_away <- webpage %>% 
    html_nodes("table") %>% 
    .[6:10] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_away[[1]]
  
  away <- colnames(table)
  
  
  
  away_table <- table_away %>% 
    reduce(full_join, by = c(away[1], away[2]))
  
  names(away_table) <- c("position", "player", headings)
  
  away_table<- away_table %>% 
    mutate(team = away_team, .before = player) %>% 
    drop_na(position) %>% 
    mutate(across(headings, as.numeric))
  
  return(away_table)
}