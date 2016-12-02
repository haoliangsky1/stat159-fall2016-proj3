# This file contains a helper function for the shinyApp.
# This function takes in all the necessary information from the user and returns a table



makeTable = function(df, stateName, ethnicity, income, SATMath, SATCR, ACTEng, ACTMath) {
	# We want to deliver a table with essential information for the top 10 choices in state or even nationally
	state = df[df$STABBR == stateName,]
	state = state[order(-state$Score),]
	# Select the first 10 schools
	state = state[1:10,]
	schoolID = as.vector(state$UNITID)
	schoolName = as.vector(state$STABBR)
	schoolScore = as.numeric(state$Score)

	# Create a new data frame for the information
	result = data.frame('Name' = schoolName)

	# Net Price
	choices = c('$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+')
	temp = df[df$STABBR %in% schoolName,]
	netPrice = c()
	if (income == '$0-$30,000') {
		netPrice = temp$NetPrice0To30
	} else if (income == '$30,001-$48,000') {
		netPrice = temp$NetPrice30To48
	} else if (income == '$48,001-$75,000') {
		netPrice = temp$NetPrice48To75
	} else if (income == '$75,001-$110,000') {
		netPrice = temp$NetPrice75To110
	} else if (income == '$110,000+') {
		netPrice = temp$NetPrice110Up
	}
	result['Net Price for Selected Family Income'] = netPrice


}