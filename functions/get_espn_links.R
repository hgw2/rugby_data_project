get_espn_links <- function(webpage){

  webpage <- read_html(webpage)
  links <- webpage %>% 
    html_nodes('a') %>% 
    html_attr("href") %>% 
    str_extract_all("/scrum/rugby/player/[0-9]+.html") %>% 
    unlist()
  
  
  player_links <- c()
  
  for (link in links){
    base_url <- "http://en.espn.co.uk"
    full <- paste(base_url,link, sep = "")
    player_links <- c(player_links, full)
  }
  
return(player_links)
  
}