# Duke WBB Analytics

Exploratory analysis of Duke women's basketball data, pulled from ESPN via the [`wehoop`](https://wehoop.sportsdataverse.org/) R package.

## Status

Early/exploratory phase — currently pulling and looking at available data (schedule, team box scores) before settling on a specific analysis direction. Candidate directions under consideration: team performance trends, opponent scouting, player/shot efficiency.

## Setup

Requires R with these packages installed:

```r
install.packages(c("wehoop", "dplyr", "tidyr", "ggplot2", "readr"))
```

No API key or login needed — `wehoop` wraps ESPN's public endpoints.

## Project structure

```
R/            analysis scripts
data/         local data files (currently empty; git-ignored data would go here)
```

## Data notes

- Duke's ESPN `team_id` is `150`.
- ESPN labels a season by the year it *ends* in (e.g. the 2025-26 season is `year = 2026`).
- `espn_wbb_team_schedule()`'s score columns come back empty for this team/season — use `load_wbb_team_box(seasons = ...)` for actual game scores/results instead.

## Scripts

- `R/01_explore.R` — pulls Duke's schedule and team box scores for the current season and does a first look at the data (most recent 10 games with scores/results).
