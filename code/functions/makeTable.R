# This file contains a helper function for the shinyApp.
# This function takes in all the necessary information from the user and returns a table



makeSchoolTable = function(df, rawDF, stateName, ethnicity, income, SATMath, SATCR, ACTEng, ACTMath) {
	# We want to deliver a table with essential information for the top 10 choices in state or even nationally
	if (stateName == 'None') {
		return
	}
	state = df[df$STABBR == stateName,]
	schoolID = as.vector(state$UNITID)
	schoolName = as.vector(state$INSTNM)
	schoolScore = as.numeric(state$Score)


	# Create a new data frame for the information
	result = data.frame('Name' = schoolName)

	# Net Price
	choices = c('None','$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+')
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

	# Ethnicity
	temp = rawDF[rawDF$STABBR %in% schoolName, ]
	choices = c('None','White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander')
	percentageOfEthnicity = c()
	if (ethnicity == 'White') {
		percentageOfEthnicity = temp$UGDS_WHITE
	} else if (ethnicity == 'Black or African American') {
		percentageOfEthnicity = temp$UGDS_BLACK
	} else if (ethnicity == 'Hispanic') {
		percentageOfEthnicity = temp$UGDS_HISP
	} else if (ethnicity == 'Asian') {
		percentageOfEthnicity = temp$UGDS_ASIAN
	} else if (ethnicity == 'American Indian/Alaska Native') {
		percentageOfEthnicity = temp$UGDS_AIAN
	} else if (ethnicity == 'Native Hawaiian/Pacific Islander') {
		percentageOfEthnicity = temp$UGDS_NHPI
	}
	result['Percentage of Selected Ethnicity'] = percentageOfEthnicity


	output = result[order(-result$Score),]
	# Select the first 10 schools
	output = output[1:10,]
	return(output)
}




