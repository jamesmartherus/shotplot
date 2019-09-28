
#testing links
whole_file <- jsonlite::fromJSON(curl::curl("https://statsapi.web.nhl.com/api/v1/game/2016020010/feed/live"))
all_plays <-  whole_file$liveData$plays$allPlays

#testing a shotplot
ggplot(shot_locations[shot_locations$team=="San Jose Sharks",], aes(x=x, y=y, label=shooter)) +
  geom_shotplot() +
  geom_label()
RCurl::url.exists("https://statsapi.web.nhl.com/api/v1/game/2017021193/feed/live")
httr::http_error("https://statsapi.web.nhl.com/api/v1/game/2017021193/feed/live")

# To Do
# make scrape_shots() faster
# get the list of urls beforehand and just load it up? But thats not the slow part of the process
# include the shot location datasets in the package?
# not always getting the correct team. Only one team is associated with each shot. For shots its the correct team.
  # for blocked shots its the blocking team. Missed shots its the 
# still not getting all urls.
# add message about how many games failed
# need to test the coordinates on my rink and probably make some adjustments.
# maybe make the rink look better. Lines a little less brightly colored
# could get the team from the "players" field which is above the livedata. 

#2013 starting at like game 400. No idea. This happened before with the 2016 one originally. Maybe rate limiting or something?
# running again on 2013 starts at the beginning. Still skipping some but fewer now. replicates twice, same ones selected.
#2014 got some but not many
#2015 got none.
#2016 got a ton (~127000)
#2017 got only 10,000. Dont know why. Then when i did it again it got 0.
#2018 got 120,000






