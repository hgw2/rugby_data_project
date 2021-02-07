start_time <- Sys.time()
library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)
source.all("functions")
source("2_scrape_data/scrape_data.R")
source("4_clean_data_script/clean_data.R")
end_time <- Sys.time()


time_taken <- end_time - start_time

print(time_taken)

