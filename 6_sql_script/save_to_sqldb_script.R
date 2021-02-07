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

if (dbExistsTable(db_connection, "matches"))
  dbRemoveTable(db_connection, "matches")

if (dbExistsTable(db_connection, "team_stats"))
  dbRemoveTable(db_connection, "team_stats")

match_data <- read_csv("5_clean_data/sql/match_data.csv")
dbWriteTable(db_connection, name = "matches", value = match_data, row.names = FALSE)

team_data <- read_csv("5_clean_data/sql/team_data.csv")
dbWriteTable(db_connection, name = "team_stats", value = team_data, row.names = FALSE)

dbGetQuery(db_connection, statement = "ALTER TABLE matches 
           ADD PRIMARY KEY (match_id);")

dbGetQuery(db_connection, statement = "ALTER TABLE team_stats
           ADD FOREIGN KEY (match_id) REFERENCES matches(match_id);")

dbDisconnect(db_connection)