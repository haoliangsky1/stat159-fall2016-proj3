library(ggmap)

plotGeo = function(stateName, df){
	if (stateName == 'all') {
		map = get_map(location = 'North America', zoom = 4)
		mapPoints = ggmap(map) + geom_point(data=df, aes(x = LONGITUDE, y = LATITUDE, size= Score), alpha= .3, color = 'red') + scale_size('Score')
		} else {
			temp = df[df$STABBR == stateName, ]
            temp = temp[order(-temp$Score), ]
            temp = temp[1:20, ]
            map = get_map(location = 'North America', zoom = 4)
            mapPoints = ggmap(map) +
            geom_point(data = temp, aes(x = LONGITUDE, y = LATITUDE, size= Score), alpha = .3,
            	color = 'red') + scale_size(name = 'Score') 
  # png('www/choiceOfState.png')
  # mapPoints
  # dev.off()
		}
		mapPoints
  
}
