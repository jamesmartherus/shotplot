#### Get shots
library(shotplot)

years <- c(2016:2018)
for(year in years){
  shots_`year` <- scrape_shots(start_season = year, end_season = year)
  save(shots_`year`, file="data/shots_`year`.rda", compress="xz")
}

