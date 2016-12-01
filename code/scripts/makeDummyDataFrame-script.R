# This file would take in the combinedData.csv dataset 
# and select columns as dummy variables for modeling and shinyApp

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#college = read.csv('data/combinedData.csv')


dummy = college[,c('UNITID', 'INSTNM','HIGHDEG','UGDS')]
# Net Price
dummy['NetPrice0-30'] =  college$NPT41_PUB + college$NPT41_PRIV
dummy['NetPrice30-48'] = college$NPT42_PUB + college$NPT42_PRIV
dummy['NetPrice48-75'] = college$NPT43_PUB + college$NPT43_PRIV
dummy['NetPrice75-110'] = college$NPT44_PUB + college$NPT44_PRIV
dummy['NetPrice110+'] = college$NPT45_PUB + college$NPT45_PRIV

# Repayment Rate
dummy['3YearRepay'] = as.numeric(college$COMPL_RPY_3YR_RT)
dummy['5YearRepay'] = as.numeric(college$COMPL_RPY_5YR_RT)

# Completion Rate
dummy['4YearCompletion'] = college$C150_4

# Earning
dummy['10YearMeanEarning'] = as.numeric(college$MN_EARN_WNE_P10)
dummy['10YearMedianEarning'] = as.numeric(college$MD_EARN_WNE_P10)

# Employment:
#dummy['10YearEmployment'] = as.numeric(college$COUNT_WNE_P10) / college$UGDS

# We only take 4-year institute
dummy = dummy[dummy$HIGHDEG %in% c(3,4),]

# Replace all PrivacySuppressed
dummy[dummy == 'PrivacySuppressed'] = NA

# Mean Centering and Standardizing
scaledDummy = dummy[,1:3]
scaledDummy[,4:ncol(dummy)] <- scale(dummy[,4:ncol(dummy)], center = TRUE, scale = TRUE)

Score = c()



