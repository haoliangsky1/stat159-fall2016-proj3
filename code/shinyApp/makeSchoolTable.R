# This file contains a helper function for the shinyApp.
# This function takes in all the necessary information from the user and returns a table

makeSchoolTable = function(df, rawDF, schoolID, stateName, ethnicity, income, SATMath, SATCR, ACTEng, ACTMath) {
	# We want to deliver a table with essential information for the top 10 choices in state or even nationally
	result = data.frame(0,0,0)
	colnames(result) = c('Name', 'NetPrice', 'PercentageEthnicity')
	if (is.na(schoolID)) {
		return(result)
	} else {
	  schoolName = as.vector(df$INSTNM[df$UNITID == schoolID])
	  schoolScore = df$Score[df$UNITID == schoolID]
	  result['Name'] = schoolName
	  # Net Price
	  result$NetPrice = getNetPrice(df, schoolID, income)
	  # Ethnicity
	  result$PercentageEthnicity = getPercentageOfEthnicity(rawDF, schoolID, ethnicity)
	  return(result)
	}
}

getNetPrice = function(df, schoolID, income) {
	choices = c('$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+')
	temp = df[df$UNITID == schoolID,]
	netPrice = NA
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
	return(netPrice)
}

getPercentageOfEthnicity = function(rawDF, schoolID, ethnicity) {
	temp = rawDF[rawDF$UNITID == schoolID, ]
	choices = c('None','White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander')
	percentageOfEthnicity = NA
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
	return(percentageOfEthnicity)
}




