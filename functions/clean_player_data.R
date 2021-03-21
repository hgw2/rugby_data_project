clean_player_data <- function() {
  files <- c()

  for (file in list.files(paste("~/rugby_data_project/3_raw_data/", format(Sys.Date(), "%Y%m%d"), "/player_data", sep = ""))) {
    file_path <- paste("~/rugby_data_project/3_raw_data/", format(Sys.Date(), "%Y%m%d"), "/player_data/", file, sep = "")
    files <- c(files, file_path)
  }

  complete_data <- NULL

  for (file in files) {
    part_data <- read_csv(file) %>%
      distinct(player, .keep_all = TRUE)


    names <- part_data %>%
      select(-competition:-player) %>%
      colnames()

    part_data <- part_data %>%
      group_by(date, match) %>%
      mutate(home_away = if_else(row_number() %in% 1:23, "home", "away"), .after = match) %>%
      ungroup() %>%
      pivot_longer(names, names_to = "stat", values_to = "values") %>%
      mutate(season = as.character(season)) %>%
      mutate(stat = recode(stat,
        "tries" = "try_scored",
        "carries_metres" = "ball_carry_meters",
        "runs" = "ball_carry",
        "defenders_beaten" = "beat_defender",
        "clean_breaks" = "line_break",
        "turnovers_conceded" = "total_turnovers_conceded",
        "points" = "points_scored",
        "tackles" = "tackle_made",
        "missed_tackles" = "tackle_missed",
        "turnover_won" = "total_turnovers_gained",
        "conversion_goals" = "conversion_successful",
        "penalty_goals" = "penalty_goal_successful",
        "drop_goals_converted" = "drop_kick_successful",
        "lineouts_won" = "lineout_won_own_throw",
        "red_cards" = "red_card",
        "yellow_cards" = "yellow_card",
        .default = stat
      )) %>%
      mutate(team = str_to_lower(team)) %>%
      mutate(team = str_replace(team, " ", "_")) %>%
      mutate(
        type_of_team = if_else(team %in% international,
          "international", "club"
        ),
        .after = team
      ) %>%
      mutate(
        hemisphere = case_when(
          competition %in% c(
            "autumn_nations_cup",
            "european_champions_cup",
            "premiership",
            "premiership_cup",
            "pro_14", "six_nations",
            "top_14"
          ) ~ "northern",
          competition %in% c(
            "internationals",
            "rugby_world_cup"
          ) ~ "mixed",
          TRUE ~ "southern"
        ),
        .after = competition
      ) # %>%
    #  mutate(match_id = paste(str_replace_all(as.character(date),"-", ""),
    #                         str_extract(match, "^[a-z0-9]{2}"),
    #                        "vs",
    #                       str_extract(match, "(?<=vs_)[a-z0-9]{2}"),
    #                      sep = "")
    #    , .before = competition)  %>%
    #  mutate(match_id = if_else(home_away == "home",
    #                           paste("h", match_id,  sep = ""),
    #                          paste("a",match_id,  sep = "")))

    complete_data <- bind_rows(complete_data, part_data)
  }

  dir.create("~/rugby_data_project/5_clean_data")
  dir.create(paste("~/rugby_data_project/5_clean_data/", format(Sys.Date(), "%Y%m%d"), sep = ""))

  complete_data %>%
    write_parquet(paste("~/rugby_data_project/5_clean_data/", format(Sys.Date(), "%Y%m%d"), "/", format(Sys.Date(), "%Y%m%d"), "_player_data.parquet", sep = ""))
}
