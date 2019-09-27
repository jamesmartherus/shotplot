#' Scrapes the NHL API for Shot Location Data
#' 
#' Scrapes the NHL Live Data for shot location data including coordinates, shot type,
#' shooting player name and team.
#' 
#' @param start_season The starting year of the first season to be scraped. For example, "2016"
#' for the 2016-2017 season.
#' @param end_season The starting year of the last season to be scraped. For example, "2016"
#' for the 2016-2017 season.
#' @keywords json curl
#' @examples
#' scrape_shots(start_season=2016, end_season=2016)
#' @import curl
#' @import RCurl
#' @import jsonlite
#' @import progress
#' @export
scrape_shots <- function(start_season=2016, end_season=2016){
  if(start_season > 2018){stop("That season has not begun yet.")}
  if(start_season > end_season){stop("start_season must be before end_season")}
  if(!is.numeric(start_season)){stop("start_season must be an integer")}
  if(!is.numeric(end_season)){stop("end_season must be an integer")}
  if(start_season==end_season){years <- start_season}
  if(start_season < end_season){years <- start_season:end_season}
  urls <- NULL
  for(year in years){
    if(year >= 2017){gms <- 1271}
    if(year < 2017){gms <- 1230}
    for(gm in 1:gms){
      game_num= formatC(gm, width=4, flag="0")
      game_id = paste0(as.character(year),"02",game_num)
      url = paste0("https://statsapi.web.nhl.com/api/v1/game/",game_id,"/feed/live")
      urls <- c(urls, url)
    }
  }
  shot_types <- c("SHOT","MISSED_SHOT","BLOCKED_SHOT","GOAL")
  shot_df <- data.frame()
  pb <- progress_bar$new(total = length(urls))
  for(u in 1:length(urls)){
    if(!RCurl::url.exists(urls[u])){next} # skip URLs that don't exist
    whole_file <- jsonlite::fromJSON(curl::curl(urls[u]))
    all_plays <- whole_file$liveData$plays$allPlays
    if(length(all_plays)==0){next} # some games don't include play-by-play data
    event_type <- whole_file$liveData$plays$allPlays$result$eventTypeId
    for(p in 1:nrow(all_plays)){
      if(event_type[p] %in% shot_types){
        play <- data.frame(shot_type=all_plays$result$event[p],
                           x=all_plays$coordinates$x[p],
                           y=all_plays$coordinates$y[p],
                           team=all_plays$team$name[p],
                           shooter=all_plays$players[p][[1]]$player$fullName[all_plays$players[p][[1]]$playerType=="Shooter" | all_plays$players[p][[1]]$playerType=="Scorer"])
        shot_df <- rbind(shot_df, play)
      }
    }
    pb$tick()
    Sys.sleep(1 / 100)
  }
  return(shot_df)
}
