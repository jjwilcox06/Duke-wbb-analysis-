# 01_explore.R
#
# Goal: just pull some real Duke WBB data and look at it. No analysis yet —
# this is about seeing what's available before deciding what's worth
# building on top of it.
#
# `wehoop` is a free R package that wraps ESPN's public women's basketball
# data (no login, no API key). Duke's ESPN team_id is 150.

library(wehoop)
library(dplyr)

duke_id <- 150

# ESPN labels a season by the year it *ends* in, so the 2025-26 season is
# `year = 2026`.
season <- 2026

# --- Schedule / results ------------------------------------------------
# One row per game: date, opponent, home/away, final score.
schedule <- espn_wbb_team_schedule(team_id = duke_id, year = season)

cat("schedule:", nrow(schedule), "rows,", ncol(schedule), "columns\n")
glimpse(schedule)

# --- Team box scores -----------------------------------------------------
# One row per team per game (so 2 rows per game: Duke + opponent) with
# points, rebounds, shooting splits, turnovers, etc.
box <- load_wbb_team_box(seasons = season)
duke_box <- box %>% filter(team_id == duke_id)

cat("\nduke_box:", nrow(duke_box), "rows,", ncol(duke_box), "columns\n")
glimpse(duke_box)

# --- A first look --------------------------------------------------------
# Note: `schedule`'s team_score/opponent_score columns come back empty from
# this endpoint (an ESPN/wehoop quirk, not a mistake on our end) — the box
# score table has the real final scores, so that's what we use here.
recent <- duke_box %>%
  arrange(desc(game_date)) %>%
  select(game_date, opponent = opponent_team_display_name,
         team_score, opponent_score = opponent_team_score, won = team_winner) %>%
  head(10)

cat("\nMost recent 10 games:\n")
print(recent)
