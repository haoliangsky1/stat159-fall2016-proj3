# This file would take in the combinedData.csv dataset 
# and select columns as dummy variables for modeling and shinyApp

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#college = read.csv('data/combinedData.csv')


dummy = college[,c('UNITID', 'INSTNM','STABBR', 'HIGHDEG','UGDS')]
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

# Proportion of Pell Grant
dummy['ProportionPellGrant'] = as.numeric(college$PCTPELL)

# Proportion of low income student
dummy['ProportionLowIncomeStudent'] = as.numeric(college$INC_PCT_LO)

  
# Median debt
dummy['MedianDebt'] = as.numeric(college$GRAD_DEBT_MDN)


# Percentage of first generation
dummy['ProportionFirstGeneration'] = as.numeric()
college$FIRST_GEN

PAR_ED_PCT_1STGEN

FIRSTGEN_COMP_ORIG_YR6_RT


# We only take 4-year institute
dummy = dummy[dummy$HIGHDEG %in% c(4,5),]

# Replace all PrivacySuppressed
dummy[dummy == 'PrivacySuppressed'] = NA

# Mean Centering and Standardizing
scaledDummy = dummy[,1:4]
scaledDummy[,5:ncol(dummy)] <- scale(dummy[,5:ncol(dummy)], center = TRUE, scale = TRUE)

Score = c()
colnames(dummy)[6:ncol(dummy)]
weight = c(-0.05, -0.05, -0.05, 0.05, 0.1, 0.1, 0.1, 0.5, 0.5, 0.5)

for (i in 1:nrow(dummy)){
  Score[i] = sum(weight * scaledDummy[i, 6:ncol(dummy)])
}


n = nrow(dummy)
for (i in 1:20) {
  print(as.vector(dummy$INSTNM[which(Score == sort(Score,partial=n-i)[n-i])]))
}

Score[which('Harvard University' == dummy$INSTNM)]
Score[which('Massachusetts Institute of Technology' == dummy$INSTNM)]
Score[which('Stanford University' == dummy$INSTNM)]
Score[which('Cornell University' == dummy$INSTNM)]
Score[which('Yale University' == dummy$INSTNM)]
Score[which('Princeton University' == dummy$INSTNM)]
Score[which('University of Chicago' == dummy$INSTNM)]
Score[which('New York University' == dummy$INSTNM)]
Score[which('University of California-Berkeley' == dummy$INSTNM)]
Score[which('University of California-Los Angeles' == dummy$INSTNM)]
Score[which('Ohio State University-Main Campus' == dummy$INSTNM)]

summary(Score)


dummyScore = dummy[,c('UNITID', 'INSTNM', 'STABBR', 'Score')]
# Output the csv for shinyApp
write.csv(dummyScore, file = 'data/schoolRanking.csv')

CA = dummyScore[dummyScore$STABBR=='CA',]
for (i in 1:10) {
  n = nrow(CA)
  print(as.vector(CA$INSTNM[which(CA$Score == sort(CA$Score,partial=n-i)[n-i])]))
}

MA = dummyScore[dummyScore$STABBR=='MA',]
for (i in 1:10) {
  n = nrow(MA)
  print(as.vector(MA$INSTNM[which(MA$Score == sort(MA$Score,partial=n-i)[n-i])]))
}

NY = dummyScore[dummyScore$STABBR=='NY',]
for (i in 1:10) {
  n = nrow(NY)
  print(as.vector(NY$INSTNM[which(NY$Score == sort(NY$Score,partial=n-i)[n-i])]))
}



