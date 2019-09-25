library(jsonlite)
library(curl)
library(purr)

get_shots <- function(start_season=2014, end_season=2019){
  years <- start_season:end_season
  urls <- NULL
  for(year in years){
    #if(game_types="reg_season"){
      if(year >= 2017){gms <- 1271}
      if(year < 2017){gms <- 1230}
      for(gm in 1:gms){
        game_num= formatC(gm, width=4, flag="0")
        game_id = paste0(as.character(year),"02",game_num)
        url = paste0("https://statsapi.web.nhl.com/api/v1/game/",game_id,"/feed/live")
        urls <- c(urls, url)
      }
   # }
  }
  return(urls)
}

shot_types <- c("SHOT","MISSED_SHOT","BLOCKED_SHOT","GOAL")
game_urls <- get_shots()

shot_df <- data.frame()
whole_file <- jsonlite::fromJSON(curl::curl(game_urls[1]))
all_plays <- whole_file$liveData$plays$allPlays
event_type <- whole_file$liveData$plays$allPlays$result$eventTypeId
for(p in 1:nrow(all_plays)){
  if(event_type[p] %in% shot_types){
    play <- data.frame(x=all_plays$coordinates$x[p],
                       y=all_plays$coordinates$y[p],
                       team=all_plays$team$name[p],
                       shooter=all_plays$players[p][[1]]$player$fullName[all_plays$players[p][[1]]$playerType=="Shooter"])
    shot_df <- rbind(shot_df, play)
  }
}

