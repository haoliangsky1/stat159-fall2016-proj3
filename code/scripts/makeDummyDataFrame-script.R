# This file would take in the combinedData.csv dataset 
# and select columns as dummy variables for modeling and shinyApp

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#college = read.csv('data/combinedData.csv')

args = commandArgs(trailingOnly =TRUE)
college = read.csv(args[1], header =T)
college = college[,2:ncol(college)]

library(ggplot2)
library(maps)
source('code/functions/normalize.R')


dummy = college[,c('UNITID', 'INSTNM','STABBR', 'HIGHDEG','UGDS', 'LONGITUDE', 'LATITUDE')]
# Net Price
dummy['NetPrice0To30'] =  college$NPT41_PUB + college$NPT41_PRIV
dummy['NetPrice30To48'] = college$NPT42_PUB + college$NPT42_PRIV
dummy['NetPrice48To75'] = college$NPT43_PUB + college$NPT43_PRIV
dummy['NetPrice75To110'] = college$NPT44_PUB + college$NPT44_PRIV
dummy['NetPrice110Up'] = college$NPT45_PUB + college$NPT45_PRIV

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

# Median debt
dummy['MedianDebt'] = as.numeric(college$GRAD_DEBT_MDN)


# Percentage of first generation
dummy['ProportionFirstGeneration'] = as.numeric(college$FIRST_GEN)

# Proportion of Degrees Awarded by Major
# Computer Science
dummy['DegreesComputerScience'] = as.numeric(college$PCIP11) + as.numeric(college$PCIP41)
# Literature
dummy['DegreesLiterature'] = as.numeric(college$PCIP23) + as.numeric(college$PCIP25)
# Mathematics and Statistics
dummy['DegreesMathematics'] = as.numeric(college$PCIP27)
# Engineering
dummy['DegreesEngineering'] = as.numeric(college$PCIP14) + as.numeric(college$PCIP15) + as.numeric(college$PCIP47) + as.numeric(college$PCIP48) + as.numeric(college$PCIP49)
# Social Studies and Humanities
dummy['DegreesSocialStudies'] = as.numeric(college$PCIP24) + as.numeric(college$PCIP42) + as.numeric(college$PCIP45)
# Visual and Performing Arts
dummy['DegreesVisualPerformingArts'] = as.numeric(college$PCIP50)
# Business
dummy['DegreesBusiness'] = as.numeric(college$PCIP52)
# History
dummy['DegreesHistory'] = as.numeric(college$PCIP54)
# Life Science/Health
dummy['DegreesLifeScienceHealth'] = as.numeric(college$PCIP26) + as.numeric(college$PCIP51) 

# Ethnicity
dummy['White'] = as.numeric(college$UGDS_WHITE)
dummy['Black'] = as.numeric(college$UGDS_BLACK)
dummy['Hispanic'] = as.numeric(college$UGDS_HISP)
dummy['Asian'] = as.numeric(college$UGDS_ASIAN)
dummy['Native'] = as.numeric(college$UGDS_AIAN)
dummy['Islander'] = as.numeric(college$UGDS_NHPI)

# Entrance standardized test scores
dummy['SATCR'] = as.numeric(college$SATVRMID)
dummy['SATMT'] = as.numeric(college$SATMTMID)
dummy['ACTEN'] = as.numeric(college$ACTENMID)
dummy['ACTMT'] = as.numeric(college$ACTMTMID)



# We only take 4-year institute
dummy = dummy[dummy$HIGHDEG %in% c(4,5),]


# Replace all PrivacySuppressed
dummy[dummy == 'PrivacySuppressed'] = NA

# Mean Centering and Standardizing
# scaledDummy = dummy[,1:7]
# scaledDummy[,8:ncol(dummy)] <- scale(dummy[,8:ncol(dummy)], center = TRUE, scale = TRUE)

write.csv(dummy, file = 'data/schoolRanking.csv')
write.csv(dummy, file = 'code/shinyApp/schoolRanking.csv')

# Output the columns and weights
vectorNames = colnames(dummy)[8:ncol(dummy)]
save(vectorNames, file='data/rData/columnNames.RData')
weightDefault = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.7, 0.7, 0.7, 0.1, -0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0,0)
save(weightDefault, file = 'data/rData/weightDefault.RData')

weightTable = matrix(ncol = 3, nrow = 19)
colnames(weightTable) = c('Variable', 'Weight', 'Condition')
weightTable[1,] = c('NetPrice', -0.05, 'Default')
weightTable[2,] = c('NetPrice', -0.3, 'Income in $0-$75,000')
weightTable[3,] = c('NetPrice', 0.4, 'Income in $75,000+')
weightTable[4,] = c('3 Year Repayment Rate', 0.1, 'Default')
weightTable[5,] = c('5 Year Repayment Rate', 0.1, 'Default')
weightTable[6,] = c('4 Year Completion Rate', 0.7, 'Default')
weightTable[7,] = c('10 Year Mean Earnings', 0.7, 'Default')
weightTable[8,] = c('10 Year Median Earnings', 0.7, 'Default')
weightTable[9,] = c('Pell Grant', 0.1, 'Default')
weightTable[10,] = c('Pell Grant', 0.5, 'Income in $0-$30,000')
weightTable[11,] = c('Median Debt', -0.1, 'Default')
weightTable[12,] = c('First Generation', 0.0, 'Default')
weightTable[13,] = c('First Generation', 0.2, 'First Generation')
weightTable[14,] = c('Major', 0.1, 'Default')
weightTable[15,] = c('Major', 0.3, 'Selected major')
weightTable[16,] = c('Ethnicity', 0.0, 'Default')
weightTable[17,] = c('Ethnicity', 0.1, 'Selected ethnicity')
weightTable[18,] = c('Test Score', 0.0, 'Default')
weightTable[19,] = c('Test Score', 0.1, 'Input test score')
save(weightTable, file = 'data/rData/weightTable.RData')

# n = nrow(dummy)
# for (i in 1:20) {
#   print(as.vector(dummy$INSTNM[which(Score == sort(Score,partial=n-i)[n-i])]))
# }

# Score[which('Harvard University' == dummy$INSTNM)]
# Score[which('Massachusetts Institute of Technology' == dummy$INSTNM)]
# Score[which('Stanford University' == dummy$INSTNM)]
# Score[which('Cornell University' == dummy$INSTNM)]
# Score[which('Yale University' == dummy$INSTNM)]
# Score[which('Princeton University' == dummy$INSTNM)]
# Score[which('University of Chicago' == dummy$INSTNM)]
# Score[which('New York University' == dummy$INSTNM)]
# Score[which('University of California-Berkeley' == dummy$INSTNM)]
# Score[which('University of California-Los Angeles' == dummy$INSTNM)]
# Score[which('Ohio State University-Main Campus' == dummy$INSTNM)]
# 
# 
# dummyScore = dummy[,c('UNITID', 'INSTNM', 'STABBR', 'LONGITUDE', 'LATITUDE')]
# dummyScore['Score'] = Score
# stateList = c('AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'ID', 'IL', 'IN','IA','KS', 'KY','LA','ME','MD','MA','MI','MN','MS','MO','MT', 'NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
# #dummyScore = dummyScore[dummyScore$STABBR %in% stateList,]
# # Output the csv for shinyApp
# 
# #write.csv(dummyScore, file = 'data/schoolRanking.csv')
# dummy['Score'] = Score
# write.csv(dummy, file = 'data/schoolRanking.csv')
# write.csv(dummy, file = 'code/shinyApp/schoolRanking.csv')
# 
# 
# 
# # Preparing data for ggplot
# p = ggplot()
# p = p + geom_polygon(data = all_states, 
#                      aes(x=long, y= lat, group = group), color = 'white')
# temp = dummyScore[dummyScore$STABBR == stateName, ]
# p = p + geom_point(data = temp, aes(x = LONGITUDE, y = LATITUDE, size = Score),
#                color = 'red') + scale_size(name = 'Score')
# p
# 
# 
# library(ggmap)
# map = get_map(location = 'North America', zoom =4)
# mapPoints = ggmap(map) +
#   geom_point(data = dummyScore, aes(x = LONGITUDE, y = LATITUDE, size= Score), alpha = .3,
#              color = 'red') + scale_size(name = 'Score') 
# 
# mapPoints
# 
# 
# CA = dummyScore[dummyScore$STABBR=='CA',]
# for (i in 1:10) {
#   n = nrow(CA)
#   print(as.vector(CA$INSTNM[which(CA$Score == sort(CA$Score,partial=n-i)[n-i])]))
# }
# 
# MA = dummyScore[dummyScore$STABBR=='MA',]
# for (i in 1:10) {
#   n = nrow(MA)
#   print(as.vector(MA$INSTNM[which(MA$Score == sort(MA$Score,partial=n-i)[n-i])]))
# }
# 
# NY = dummyScore[dummyScore$STABBR=='NY',]
# for (i in 1:10) {
#   n = nrow(NY)
#   print(as.vector(NY$INSTNM[which(NY$Score == sort(NY$Score,partial=n-i)[n-i])]))
# }



