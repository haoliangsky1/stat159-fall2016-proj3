library(ggmap)

plotGeo = function(stateName, df){
  temp = df[df$STABBR == stateName, ]
temp = temp[order(-temp$Score), ]
  map = get_map(location = 'North America', zoom = 5)
  mapPoints = ggmap(map) +
    geom_point(data = dummyScore, aes(x = LONGITUDE, y = LATITUDE, size= Score), alpha = .3,
               color = 'red') + scale_size(name = 'Score') 
  png('../../images/choiceOfState.png')
  mapPoints
  dev.off()
}
