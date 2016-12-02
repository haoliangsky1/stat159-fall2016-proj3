# This file contains a helper function for the shinyApp.
# This function returns schools with rankings


makeRankingTable = function(df, stateName) {
	if (stateName == 'None') {
		state = df[, c('UNITID', 'INSTNM', 'STABBR','Score')]
	} else {
		state = df[df$STABBR == stateName ,c('UNITID', 'INSTNM', 'STABBR','Score')]
	}
	schoolID = as.vector(state$UNITID)
	schoolName = as.vector(state$INSTNM)
	schoolScore = as.numeric(state$Score)
	result = state[,c('INSTNM', 'STABBR','Score')]
	result = result[order(-result$Score), ]
	output = result[, ]
	output['Ranking'] = c(1:nrow(output))
	colnames(output) = c('Name', 'State', 'Score', 'Ranking')
	return(output)
}

