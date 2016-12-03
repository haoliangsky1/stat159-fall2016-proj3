# This is the file for Exploratory Data Analysis 
# of the dataset for the project

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#college = read.csv('data/combinedData.csv')
library(plyr)
library(maps)
library(ggplot2)
library(grDevices)
library(ggmap)
source('code/functions/getSummary.R')
args = commandArgs(trailingOnly =TRUE)
college = read.csv(args[1], header =T)
college = college[,2:ncol(college)]

# First the overall information
dim(college)
print('There are 6715 colleges in our dataset')

# We first draw a basic distribution of the colleges in the state
stateTable=count(college, 'STABBR')
# AS: American Samoa
# FM: Micronesia
# GU: Guam
# PW: Palau
# VI: U.S. Virgin Islands
all_states = map_data('state')

# Getting the long and lat
year15 = read.csv('data/reducedData/year15.csv')
# We list all the states in mainland USA
stateList = c('AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'ID', 'IL', 'IN','IA','KS', 'KY','LA','ME','MD','MA','MI','MN','MS','MO','MT', 'NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
stateData = year15[year15$UNITID %in% college$UNITID, ]
stateData = stateData[stateData$STABBR %in% stateList,]
stateData = stateData[is.na(stateData$UGDS) == FALSE,]

# Output as plot
print('plotting: ggmap-schoolDistribution.png')
png('images/ggmap-schoolDistribution.png')
# p = ggplot()
# p = p + geom_polygon(data = all_states, 
#                      aes(x=long, y= lat, group = group), color = 'white')
# p = p + geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size = UGDS),
#                    color = 'red') + scale_size(name = 'Undergraduate Enrollment ')
# p
map = get_map(location = 'North America', zoom =4)
mapPoints = ggmap(map) +
  geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size= UGDS), alpha = .3,
             color = 'red') + scale_size(name = 'Undergraduate Enrollment') 

mapPoints
dev.off()

png('code/shinyApp/www/ggmap-schoolDistribution.png')
mapPoints
dev.off()

## Admission Rate, We may use 40% as threshold
temp = year15[year15$UNITID %in% college$UNITID, ]
temp = temp[temp$STABBR %in% stateList, ]
admissionData =  temp[!is.na(temp$ADM_RATE), ]
admissionData = admissionData[admissionData$ADM_RATE < 0.4, ]
# Output as plot
print('plotting: ggmap-admissionRateDistribution.png')
png('images/ggmap-admissionRateDistribution.png')
# p = ggplot()
# p = p + geom_polygon(data = all_states, 
#                      aes(x=long, y= lat, group = group), color = 'white')
# p = p + geom_point(data = admissionData, aes(x = LONGITUDE, y = LATITUDE, size = 1-ADM_RATE),
#                    color = 'red') + scale_size(name = 'Undergraduate Rejection Rate')
# #p = p + geom_text(data = stateData, hjust = 0.5, vjust = -0.5, aes(x = LONGITUDE, y = LATITUDE, label = label), color = 'gold2', size = 4)
# p
map = get_map(location = 'North America', zoom =4)
mapPoints = ggmap(map) +
  geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size= 1-ADM_RATE), alpha = .3,
             color = 'red') + scale_size(name = 'Undergraduate Rejection Rate') 

mapPoints
dev.off()

png('code/shinyApp/www/ggmap-admissionRateDistribution.png')
mapPoints
dev.off()


# Flag for Historically Black College and University
HBCUTable = count(college, 'HBCU')
HBCUTable[,1] = c('No', 'Yes')
HBCUTable$RelativeFrequency = HBCUTable$freq / sum(HBCUTable$freq)
colnames(HBCUTable)[2] = 'Frequency'
print('table: Flag for Historically Black College and University')
save(HBCUTable, file = 'data/rData/table-HBCU.RData')


print('table: Flag for predominantly black institution')
# Flag for predominantly black institution
PBITable = count(college, 'PBI')
PBITable[,1] = c('No', 'Yes')
PBITable$RelativeFrequency = PBITable$freq / sum(PBITable$freq)
colnames(PBITable)[2] = 'Frequency'
save(PBITable, file = 'data/rData/table-PBI.RData')

print('table: Flag for Alaska Native Hawaiian serving institution')
# Flag for Alaska Native Hawaiian serving institution
ANNHITable = count(college, 'ANNHI')
ANNHITable[,1] = c('No', 'Yes')
ANNHITable$RelativeFrequency = ANNHITable$freq / sum(ANNHITable$freq)
colnames(ANNHITable)[2] = 'Frequency'
save(ANNHITable, file = 'data/rData/table-ANNHI.RData')

print('table: Flag for tribal college and university')
# Flag for tribal college and university
TRIBALTable = count(college, 'TRIBAL')
TRIBALTable[,1] = c('No', 'Yes')
TRIBALTable$RelativeFrequency = TRIBALTable$freq / sum(TRIBALTable$freq)
colnames(TRIBALTable)[2] = 'Frequency'
save(TRIBALTable, file = 'data/rData/table-TRIBAL.RData')

print('table: Flag for Asian American Native American PacificIslander-serving institution')
# Flag for Asian American Native American PacificIslander-serving institution
AANAPIITable = count(college, 'AANAPII')
AANAPIITable[,1] = c('No', 'Yes')
AANAPIITable$RelativeFrequency = AANAPIITable$freq / sum(AANAPIITable$freq)
colnames(AANAPIITable)[2] = 'Frequency'
save(AANAPIITable, file = 'data/rData/table-AANAPII.RData')

print('table: Flag for Hispanic-serving institution')
# Flag for Hispanic-serving institution
HSITable = count(college, 'HSI')
HSITable[,1] = c('No', 'Yes')
HSITable$RelativeFrequency = HSITable$freq / sum(HSITable$freq)
colnames(HSITable)[2] = 'Frequency'
save(HSITable, file = 'data/rData/table-HSI.RData')

# Total Share of enrollment of undergraduate degree-seeking students who are White
ugdsWhite = college$UGDS_WHITE
# Total Share of enrollment of undergraduate degree-seeking students who are Black
ugdsBlack = college$UGDS_BLACK
# Total Share of enrollment of undergraduate degree-seeking students who are hispanic
ugdsHisp = college$UGDS_HISP
# Total Share of enrollment of undergraduate degree-seeking students who are Asian
ugdsAsian = college$UGDS_ASIAN
# Total Share of enrollment of undergraduate degree-seeking students who are American Indian/Alaska Native
ugdsAian = college$UGDS_AIAN
# Total Share of enrollment of undergraduate degree-seeking students who are Native Hawaiian/Pacific Islander
ugdsNhpi = college$UGDS_NHPI
# Total Share of enrollment of undergraduate degree-seeking students who are non-resident aliens
ugdsNra = college$UGDS_NRA

print('plotting: piechart-enrollmentEthnicity.png')
ugdsPiechart = c(mean(ugdsWhite), mean(ugdsBlack), mean(ugdsHisp), mean(ugdsAsian), mean(ugdsAian),  mean(ugdsNhpi) ,mean(ugdsNra))
#save(ugdsPiechart, file = 'data/rData/ugdsPiechart.RData')
png('images/piechart-enrollmentEthnicity.png')
pie(ugdsPiechart, labels = c('White', 'Black', 'Hispanic','Asian', 'Native', 'Islander', 'Non-resident'), 
    radius = 1, main = 'Piechart for Ethniticy of Enrollment of Undergraduate Students', 
    col = c('white', 'black', 'red', 'yellow', 'green', 'blue', 'orange'))
dev.off()


# Make a parrelle plot here to compare the net price of public and private institutions

# par(mfrow=c(1,2))
# hist(college$NPT4_PUB[college$NPT4_PUB>0])
# hist(college$NPT4_PRIV[college$NPT4_PRIV>0])
# par(mfrow=c(1,1))

NPPub = getSummary(college$NPT4_PUB[college$NPT4_PUB>0])
NPPriv = getSummary(college$NPT4_PRIV[college$NPT4_PRIV>0])
NPTable = rbind(NPPub, NPPriv)
rownames(NPTable) = c('Public', 'Private')
print('table: netPrice')
save(NPTable, file = 'data/rData/table-netPrice.RData')

temp = college$COSTT4_A


# png('images/ggplot-schoolDistribution.png')
# p = ggplot()
# p = p + geom_polygon(data = all_states, 
#                      aes(x=long, y= lat, group = group), color = 'white')
# p = p + geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size = COSTT4_A),
#                    color = 'red') + scale_size(name = 'Average Cost of Attendance ')
# #p = p + geom_text(data = stateData, hjust = 0.5, vjust = -0.5, aes(x = LONGITUDE, y = LATITUDE, label = label), color = 'gold2', size = 4)
# p
# dev.off()


temp = college$TUITIONFEE_IN
temp = college$TUITIONFEE_OUT
temp = college$TUITIONFEE_PROG


temp = college$INEXPFTE



# Entrance Test Score Summary
# SAT
SATCR = college$SATVRMID
SATCR = SATCR[SATCR != 0]
print('plotting: histogram-SATCRMedian.png')
png('images/histogram-SATCRMedian.png')
hist(SATCR, main = 'Histogram of Median of SAT Critical Reading Scores')
#abline(v = mean(SATCR), col = 'red')
dev.off()
SATCRTable = getSummary(SATCR)
save(SATCRTable, file = 'data/rData/table-SATCR.RData')
length(SATCR)

SATMT = college$SATMTMID
SATMT = SATMT[SATMT != 0]
print('plotting: histogram-SATMTMedian.png')
png('images/histogram-SATMTMedian.png')
hist(SATMT, main = 'Histogram of Median of SAT Math Scores')
dev.off()
SATMTTable = getSummary(SATMT)
save(SATMTTable, file = 'data/rData/table-SATMT.RData')

# ACT
ACTEN = college$ACTENMID
ACTEN = ACTEN[ACTEN != 0]
print('plotting: histogram-ACTENMedian.png')
png('images/histogram-ACTENMedian.png')
hist(ACTEN, main = 'Histogram of Median of ACT English')
dev.off()
ACTENTable = getSummary(ACTEN)
save(ACTENTable, file = 'data/rData/table-ACTEN.RData')


length(ACTEN)

ACTMT = college$ACTMTMID
ACTMT = ACTMT[ACTMT != 0]
print('plotting: histogram-ACTMTMedian.png')
png('images/histogram-ACTMTMedian.png')
hist(ACTMT, main = 'Histogram of Median of ACT Math')
dev.off()
ACTMTTable = getSummary(ACTMT)
save(ACTMTTable, file = 'data/rData/table-ACTMT.RData')


# Need criteria for good school
# Salary?
# Entrance SAT?

# Financial support?


