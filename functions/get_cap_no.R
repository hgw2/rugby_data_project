get_cap_no <- function(webpage, country){
  
  dir.create("~/rugby_data_project/3_raw_data/cap_nos/")

  webpage <- read_html(webpage)
  cap_nos <- webpage %>% 
    html_nodes("tr+ tr td:nth-child(1)") %>% 
    html_text()
  
  links <- webpage %>% 
    html_nodes('a') %>% 
    html_attr("href") %>% 
    str_extract_all("/scrum/rugby/player/[0-9]+.html") %>% 
    unlist()
  
 name <- webpage %>% 
    html_nodes("tr+ tr td:nth-child(2)") %>% 
    html_text()

 country_upper <- country %>% 
   str_replace_all("_", " ") %>% 
   str_to_title()
 
 cap_nos <- tibble(cap_nos,
         name, links) %>% 
   mutate(country = country_upper, .before = cap_nos) %>% 
   mutate(espn_no =  str_extract(links, "[0-9]+(?=.html)"), .after = cap_nos) %>% 
   select(-links)
  

 
 file_path <- paste("~/rugby_data_project/3_raw_data/cap_nos/", country, ".csv", sep = "")
 
 cap_nos%>% 
   write_csv(file_path)
  
}