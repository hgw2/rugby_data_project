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
  bigint = "numeric",
  options="-c search_path=staging"
)

<<<<<<< HEAD
dbGetQuery(db_connection, statement = "drop TABLE if exists staging.team;")

dbGetQuery(db_connection, statement = "create table staging.team
(
    competition              varchar(50),
    hemisphere               varchar(50),
    season                   varchar(50),
    date                     date,
    match                    varchar(50),
    home_away                varchar(50),
    team                     varchar(50),
    type_of_team             varchar(50),
    try_scored               int,
    ball_carry_meters        int,
    ball_carry               int,
    beat_defender            int,
    line_break               int,
    passes                   int,
    offload                  int,
    total_turnovers_conceded int,
    try_assist               int,
    points_scored            int,
    tackle_made              int,
    tackle_missed            int,
    total_turnovers_gained   int,
    kicks_from_hand          int,
    conversion_successful    int,
    penalty_goal_successful  int,
    drop_kick_successful     int,
    lineout_throw_won_clean  int,
    lineout_won_own_throw    int,
    lineout_won_steal        int,
    penalties_conceded       int,
    red_card                 int,
    yellow_card              int,
    possession              float,
    drop_goal_missed         int,
    penalty_missed           int,
    conversion_missed        int,
    rucks_won                int,
    rucks_lost               int,
    mauls_won                int,
    scrum_won                int,
    scrum_lost               int
);
")
team_data <- read_parquet(paste("~/rugby_data_project/5_clean_data/", format(Sys.Date(), "%Y%m%d"), "/", format(Sys.Date(), "%Y%m%d"), "_team_data.parquet", sep = ""))
dbWriteTable(db_connection, "team", team_data, append = TRUE, row.names = FALSE)

dbGetQuery(db_connection, statement = "drop TABLE if exists staging.player;")      
dbGetQuery(db_connection, statement = "create table staging.player
(
    competition              varchar(50),
    hemisphere               varchar(50),
    season                   varchar(50),
    date                     date,
    match                    varchar(50),
    home_away                varchar(50),
    position                 varchar(50),
    team                     varchar(50),
    type_of_team             varchar(50),
    player                   varchar(50),
    try_scored               int,
    ball_carry_meters        int,
    ball_carry               int,
    beat_defender            int,
    line_break               int,
    passes                   int,
    offload                  int,
    total_turnovers_conceded int,
    try_assist               int,
    points_scored            int,
    tackle_made              int,
    tackle_missed            int,
    total_turnovers_gained   int,
    kicks_from_hand          int,
    conversion_successful    int,
    penalty_goal_successful  int,
    drop_kick_successful     int,
    lineout_throw_won_clean  int,
    lineout_won_own_throw    int,
    lineout_won_steal        int,
    penalties_conceded       int,
    red_card                 int,
    yellow_card              int
);
")
           
player_data <- read_parquet(paste("~/rugby_data_project/5_clean_data/", format(Sys.Date(), "%Y%m%d"), "/", format(Sys.Date(), "%Y%m%d"), "_player_data.parquet", sep = ""))
dbWriteTable(db_connection, "player", player_data, append = TRUE, row.names = FALSE)
=======
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
>>>>>>> parent of 22971ce (added SQL script)

dbDisconnect(db_connection)