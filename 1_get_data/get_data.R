start_time <- Sys.time()
library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)
library(splitstackshape)
library(RPostgres)
wd <- Sys.getenv("HOME")
wd <- file.path(wd, "rugby_data_project")
source.all(file.path(wd,"functions"))
source("~/rugby_data_project/2_scrape_data/scrape_data.R")
source("~/rugby_data_project/2_scrape_data/scrape_espn_data.R")
source("~/rugby_data_project/4_clean_data_script/clean_data.R")
source("~/rugby_data_project/6_sql_script/save_to_sqldb_script.R")
end_time <- Sys.time()


time_taken <- end_time - start_time

print(time_taken)


