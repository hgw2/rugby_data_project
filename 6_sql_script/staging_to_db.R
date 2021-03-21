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
  bigint = "numeric")

dbGetQuery(db_connection, statement = "
INSERT INTO team_matches.international
SELECT *
FROM staging.team
WHERE type_of_team = 'international';
           ")
dbGetQuery(db_connection, statement = "
INSERT INTO team_matches.club
SELECT *
FROM staging.team
WHERE type_of_team = 'club';
           ")

dbGetQuery(db_connection, statement = "
INSERT INTO player_matches.international
SELECT *
FROM staging.player
WHERE type_of_team = 'international';
           ")

dbGetQuery(db_connection, statement = "
INSERT INTO player_matches.club
SELECT *
FROM staging.player
WHERE type_of_team = 'club';
           ")


dbDisconnect(db_connection)