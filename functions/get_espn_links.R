get_espn_links <- function(webpage, country){

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
  
  file_path <- paste("~/rugby_data_project/2_scrape_data/", country,"_links", ".RData", sep = "")
  file_name <- paste(country,"_links",  sep = "")
  
  if(file.exists(file_path)){
    load(file_path)
    
    links <- setdiff(player_links, old_links)
    
    if (is.null(links)){
      print("Up to date")
    } else{
      links <- links
    }
    
  } else{
    links <- player_links
    
  }
  
  old_links <- player_links
  
  save(old_links, file = file_path)
  
return(links)
  
}