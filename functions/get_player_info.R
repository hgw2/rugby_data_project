get_player_info <- function(website) {
  webpage <- read_html(website)
  espn_no <- str_extract(webpage, "[0-9]+(?=.html)")
  info <- webpage %>%
    html_nodes(".scrumPlayerDesc") %>%
    html_text()

  name <- webpage %>%
    html_nodes(".scrumPlayerName") %>%
    html_text()

  countries_represented <- webpage %>%
    html_nodes(".scrumPlayerCountry") %>%
    html_text()

  clubs <- webpage %>%
    html_nodes("table") %>%
    html_table(fill = TRUE)



  caps <- webpage %>%
    html_nodes("table") %>%
    html_table(fill = TRUE)

  caps <- caps[[2]] %>%
    rename("test" = "")

  test <- caps %>%
    pull(test)

  if ("British and Irish Lions" %in% test) {
    caps <- caps[2, 3]
  } else {
    caps <- caps[1, 3]
  }

  info <- info %>%
    str_replace_all("\n", " ")

  full_name <- str_trim(str_extract(info[1], "(?<=Full name) [A-z. ]+"))

  if (str_detect(info[2], "Also|Nick")) {
    birth_date <- str_trim(str_extract(info[3], "(?<=Born)[A-z0-9', ]*[0-9]{4}"))

    birth_location <- str_trim(str_extract(info[3], "[^,0-9)][A-z-& ]*[ A-z'-.?&]+$"))

    teams <- str_trim(str_extract(info[5], "(?<=Major teams) [A-z0-9-, ]+"))

    teams <- str_split(teams, ", ") %>%
      unlist() %>%
      as_tibble()

    clubs <- teams %>%
      filter(!str_detect(value, "Scot|Brit|Engl|Barb|Ital|Ire|Wal|Aus|Fra|Zeal|Fiji|Georg|Argent|South Africa")) %>%
      pull() %>%
      paste(collapse = ", ")

    position <- str_trim(str_extract(info[6], "(?<=Position) [A-z0-9- ]+"))

    height <- str_trim(str_extract(info[7], "(?<=Height) [A-z 0-9 ]+"))

    weight <- str_trim(str_extract(info[8], "(?<=Weight) [A-z- 0-9]+"))
  } else {
    birth_date <- str_trim(str_extract(info[2], "(?<=Born)[A-z0-9', ]*[0-9]{4}"))

    birth_location <- str_trim(str_extract(info[2], "[^,0-9)][A-z-& ]*[ A-z'-.?&]+$"))

    teams <- str_trim(str_extract(info[4], "(?<=Major teams) [A-z0-9-, ]+"))

    teams <- str_split(teams, ", ") %>%
      unlist() %>%
      as_tibble()

   clubs <- teams %>%
      filter(!str_detect(value, "World|Anglo|Scot|Brit|Engl|Barb|Ital|Ire|Wal|Aus|Fra|Zeal|Fiji|Georg|Argent|South Africa")) %>%
      pull() %>%
      paste(collapse = ", ")

    position <- str_trim(str_extract(info[5], "(?<=Position) [A-z0-9- ]+"))

    height <- str_trim(str_extract(info[6], "(?<=Height) [A-z 0-9 ]+"))

    weight <- str_trim(str_extract(info[7], "(?<=Weight) [A-z- 0-9]+"))
  }
  info <- tibble(
    espn_no,
    countries_represented,
    name,
    full_name,
    caps,
    birth_date,
    birth_location,
    position,
    clubs,
    height,
    weight
  )

  return(info)
}
