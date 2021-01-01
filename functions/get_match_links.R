get_match_links <- function(webpage){
  
  webpages <- read_html(webpage)
  
  links <- webpages %>% 
    html_nodes("a") %>% 
    html_attr("href") %>% 
    str_extract_all( "https://www.rugbypass.com/live/[a-z0-9-]+/[a-z0-9-]+/[a-z0-9-]+") %>% 
    unlist()
  
  links <- links[!is.na(links)]
  
  stats_link <- c()
  for (link in links){
    new_link <- paste(link, "/stats/", sep = "")
    stats_link <- c(stats_link, new_link)
  }
  return(stats_link)
}
 