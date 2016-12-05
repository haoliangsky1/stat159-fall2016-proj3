# This file contains a helper function for the shinyApp.
# This function takes in all the necessary information from the user and returns a table

makeSchoolTable = function(df, rawDF, schoolID, stateName, ethnicity='None', income='$0-$30,000', major='None', SATMath=0, SATCR=0, ACTEng=0, ACTMath=0) {
	# We want to deliver a table with essential information for the top 10 choices in state or even nationally
	result = data.frame(0,0,0,0,0,0,0,0)
	colnames(result) = c('Name', 'NetPrice', 'PercentEthnicity', 'PercentMajor', 'medianSATCR', 'medianSATMath', 'medianACTEng', 'medianACTMath')
	if (is.na(schoolID)) {
		return(result)
	} else {
	  schoolName = as.vector(df$INSTNM[df$UNITID == schoolID])
	  schoolScore = df$Score[df$UNITID == schoolID]
	  # Name
	  result$Name = schoolName
	  # Net Price
	  result$NetPrice = getNetPrice(df, schoolID, income)
	  # Ethnicity
	  result$PercentEthnicity = getPercentageOfEthnicity(rawDF, schoolID, ethnicity)
	  # Major
	  result$PercentMajor = getPercentageOfMajor(df, schoolID, major)
	  # Standardized Test
	  temp = df[df$UNITID == schoolID,]
	  result$medianSATCR = temp$SATCR
	  result$medianSATMath = temp$SATMT
	  result$medianACTEng = temp$ACTEng
	  result$medianACTMath = temp$ACTMath
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

getPercentageOfMajor = function(df, schoolID, major) {
	temp = df[df$UNITID == schoolID, ]
	choices = c('None','Computer Science','Literature','Mathematics/Statistics','Engineering','Social Studies/Humanities',
                                     'Visual and Perfoming Arts','Business','History', 'Life Science/Health')
	PercentageOfMajor = NA
	if (major == 'Computer Science') {
		PercentageOfMajor = temp$DegreesComputerScience
	} else if (major == 'Literature') {
	    PercentageOfMajor = temp$DegreesLiterature
	} else if (major == 'Mathematics/Statistics'){
	    PercentageOfMajor = temp$DegreesMathematics
	} else if (major == 'Engineering') {
	    PercentageOfMajor = temp$DegreesEngineering
	} else if (major == 'Social Studies/Humanities') {
	    PercentageOfMajor = temp$DegreesSocialStudies
    } else if (major == 'Visual and Performing Arts') {
        PercentageOfMajor = temp$DegreesVisualPerformingArts
    } else if (major == 'Business') {
        PercentageOfMajor = temp$DegreesBusiness
    } else if (major == 'History') {
        PercentageOfMajor = temp$DegreesHistory
    } else if (major == 'Life Science/Health') {
        PercentageOfMajor = temp$DegreesLifeScienceHealth
    }
	return(PercentageOfMajor)
}





