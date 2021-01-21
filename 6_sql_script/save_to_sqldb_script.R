library(RPostgres)
library(tidyverse)
source("../credentials/rugby_credentials.R")

db_connection = dbConnect(
  drv = Postgres(), 
  user = rugby_username,
  password = rugby_password,
  dbname = rugby_dbname,
  host = rugby_host,
  port = rugby_port,
  bigint = "numeric"
)

match_data <- read_csv("5_clean_data/sql/match_data.csv")
dbWriteTable(db_connection, name = "matches", value = match_data, row.names = FALSE)

team_data <- read_csv("5_clean_data/sql/team_data.csv")
dbWriteTable(db_connection, name = "team_stats", value = team_data, row.names = FALSE)


dbListTables(conn = db_connection)

dbDisconnect(db_connection)