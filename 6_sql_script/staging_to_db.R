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
SELECT s.*
FROM staging.team s
WHERE s.type_of_team = 'international' AND NOT EXISTS(
	SELECT *
	FROM team_matches.international db
	WHERE s.MATCH = db.match AND s.date=db.date 
);

           ")
dbGetQuery(db_connection, statement = "
INSERT INTO team_matches.club
SELECT s.*
FROM staging.team s
WHERE s.type_of_team = 'club' AND NOT EXISTS(
	SELECT *
	FROM team_matches.club db
	WHERE s.MATCH = db.match AND s.date=db.date 
);
           ")

dbGetQuery(db_connection, statement = "
INSERT INTO player_matches.international
SELECT s.*
FROM staging.player s
WHERE s.type_of_team = 'international' AND NOT EXISTS(
	SELECT *
	FROM player_matches.international db
	WHERE s.MATCH = db.match AND s.date=db.date 
)
           ")

dbGetQuery(db_connection, statement = "
INSERT INTO player_matches.club
SELECT s.*
FROM staging.player s
WHERE s.type_of_team = 'club' AND NOT EXISTS(
	SELECT *
	FROM player_matches.club db
	WHERE s.MATCH = db.match AND s.date=db.date 
)
           ")


dbDisconnect(db_connection)