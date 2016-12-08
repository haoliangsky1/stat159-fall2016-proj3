# This is the file for Exploratory Data Analysis 
# of the dataset for the project

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")

college = read.csv('data/combinedData.csv')
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

# Combined table:
flagTable = matrix(ncol=3, nrow = 12)
flagTable[1:2,1:2] = as.matrix(count(college, 'HBCU'))
flagTable[1:2, 3] = HBCUTable$RelativeFrequency
flagTable[3:4,1:2] = as.matrix(count(college, 'PBI'))
flagTable[3:4, 3] = PBITable$RelativeFrequency
flagTable[5:6,1:2] = as.matrix(count(college, 'ANNHI'))
flagTable[5:6, 3] = ANNHITable$RelativeFrequency
flagTable[7:8,1:2] = as.matrix(count(college, 'TRIBAL'))
flagTable[7:8,3] = TRIBALTable$RelativeFrequency
flagTable[9:10,1:2] = as.matrix(count(college, 'AANAPII'))
flagTable[9:10,3] =  AANAPIITable$RelativeFrequency
flagTable[11:12,1:2] = as.matrix(count(college, 'HSI'))
flagTable[11:12,3] =  HSITable$RelativeFrequency
colnames(flagTable) = c('Flag', 'Count', 'RelativeFrequency')
flagTable[,1] = c('Non Historically Black','Historically Black', 'Non Predominantly Black','Predominantly Black', 'Non Alaska Native Hawaiian serving','Alaska Native Hawaiian serving', 'Non Tribal','Tribal', 'Non Asian American Native American Pacific Islander','Asian American Native American Pacific Islander', 'Non Hispanic', 'Hispanic')
flagTable[,3] = round(as.numeric(flagTable[,3]), digit =3)
save(flagTable, file = 'data/rData/table-flag.RData')

#Proportion of degrees
prop_compsci <- college$PCIP11 + college$PCIP41
prop_literature <- college$PCIP23 + college$PCIP25
prop_math <- college$PCIP27
prop_engineering <- college$PCIP14 + college$PCIP15 + college$PCIP47 + college$PCIP48 + college$PCIP49
prop_socialstudies <- college$PCIP24 + college$PCIP45    
prop_visualarts <-  college$PCIP50
prop_business <- college$PCIP52

prop_history = college$PCIP54

# Life Science/Health
prop_lifesciencehealth = college$PCIP26 + college$PCIP51 

propdeg_pie <- c(mean(prop_compsci), mean(prop_literature), 
                 mean(prop_math), mean(prop_engineering), mean(prop_socialstudies),     
                 mean(prop_visualarts),
                 mean(prop_business), 
                 mean(prop_history))

progdeg_barplot <- c(mean(prop_compsci), mean(prop_literature), 
                     mean(prop_math), mean(prop_engineering), mean(prop_socialstudies),   
                     mean(prop_visualarts),
                     mean(prop_business), 
                     mean(prop_history))

png('images/piechart-proportionofDegrees.png')

pie(propdeg_pie, labels = c('Computer Sciece', 'Literature', 'Mathematics', 'Engineering',
                            'Social Studies', 'Visual Performing Arts', 'Business', 'History','LifeScienceHealth'), radius = 1, main = 'Piechart for Degree Proportion')
dev.off()

#barplot(progdeg_barplot, labels = c('Computer Sciece', 'Literature', 'Mathematics', 'Engineering',
#                                   'Social Studies', 'Visual Performing Arts', 'Business', 'History','LifeScienceHealth'), radius = 1, main = 'Piechart for Degree Proportion', main = 'Barplot for Degree Proportion')



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


# Analyze collumns:
# NPT college$NPT41_PUB + college$NPT41_PRIV
# average net price by income quantile
# NPPub_Q1:
# (1) $0-$30,000;
NPPub_Q1 = getSummary(college$NPT41_PUB[college$NPT41_PUB>0])
NPPriv_Q1 = getSummary(college$NPT41_PRIV[college$NPT41_PRIV>0])
NPTable_Q1 = rbind(NPPub_Q1, NPPriv_Q1)
rownames(NPTable_Q1) = c('Public quantile 1', 'Private quantile 1')

#histogram for Public college-income quintile 1
png('images/histogram-NPPub_Q1.png')
hist(NPPub_Q1, main = 'Histogram of Average Net Price in Quantile 1')
dev.off()

#histogram for private colleges - income quintile 2
png('images/histogram-NPPriv_Q1.png')
hist(NPPriv_Q1, main = 'Histogram of Average Net Price for Private colleges in Quantile 1')
dev.off()

#(2)$30,001-$48,000; 
NPPub_Q2 = getSummary(college$NPT42_PUB[college$NPT42_PUB>0])
NPPriv_Q2 = getSummary(college$NPT42_PRIV[college$NPT42_PRIV>0])
NPTable_Q2 = rbind(NPPub_Q2, NPPriv_Q2)
rownames(NPTable_Q2) = c('Public quantile 2', 'Private quantile 2')
print('table: netPrice Q2')
save(NPTable_Q2, file = 'data/rData/table-netPrice_quintile2.RData')


#save
png('images/histogram-meanNetPrice.png')
par(mfrow=c(1,2), oma = c(0,0,2,0))
hist(college$NPT42_PUB[college$NPT42_PUB>0], main = "Public Institute" , xlim = c(0, 60000), xlab = 'US Dollar')
abline(v = median(college$NPT42_PUB[college$NPT42_PUB>0]), col ='red')
hist(college$NPT42_PRIV[college$NPT42_PRIV>0], main  = 'Private Institute', xlim = c(0,60000), xlab = 'US Dollar')
abline(v = median(college$NPT42_PRIV[college$NPT42_PRIV>0]), col = 'red')
mtext('Histogram of Average Net Price', outer = T)
dev.off()

par(mfrow = c(1,1))

# (3) $48,001-$75,000; 
NPPub_Q3 = getSummary(college$NPT43_PUB[college$NPT43_PUB>0])
NPPriv_Q3 = getSummary(college$NPT43_PRIV[college$NPT43_PRIV>0])
NPTable_Q3 = rbind(NPPub_Q3, NPPriv_Q3)
rownames(NPTable_Q3) = c('Public quantile 3', 'Private quantile 3')
print('table: netPrice Q2')
save(NPTable_Q3, file = 'data/rData/table-netPrice_quintile3.RData')

#  (4) $75,001-$110,000;
NPPub_Q4 = getSummary(college$NPT44_PUB[college$NPT44_PUB>0])
NPPriv_Q4 = getSummary(college$NPT44_PRIV[college$NPT4$PRIV>0])
NPTable_Q4 = rbind(NPPub_Q4, NPPriv_Q4)
rownames(NPTable_Q4) = c('Public quantile $', 'Private quantile 4')
print('table: netPrice Q4')
save(NPTable_Q4, file = 'data/rData/table-netPrice_quintile4.RData')


#(5) $110,000.
NPPub_Q5 = getSummary(college$NPT45_PUB[college$NPT45_PUB>0])
NPPriv_Q5 = getSummary(college$NPT45_PRIV[college$NPT45$PRIV>0])
NPTable_Q5 = rbind(NPPub_Q5, NPPriv_Q5)
rownames(NPTable_Q5) = c('Public quantile 5', 'Private quantile 5')
print('table: netPrice Q5')
save(NPTable_Q5, file = 'data/rData/table-netPrice_quintile5.RData')

#a = lapply()
#do.call("rbind", a)



# Repayment Rate
# #Summarry statistics for Monthly earnings P6
# temp_P6 = college$MN_EARN_WNE_P6
# temp_P6[temp_P6=='PrivacySuppressed'] = NA
# college$MN_EARN_WNE_P6 = as.numeric(temp_P6)
# MN_EARN_6 <- college$MN_EARN_WNE_P6
# getSummary(MN_EARN_6)
# hist(MN_EARN_P6)
#cols <- c("COMPL_RPY_3YR_RT", "COMPL_RPY_5YR_RT")


temp_Rpy3 <- college$COMPL_RPY_3YR_RT
temp_Rpy3[temp_Rpy3=='PrivacySuppressed'] = NA
Col_repay3 = as.numeric(temp_Rpy3)

png('images/histogram-Col-repay3.png')
hist(Col_repay3, xlab = "Rate", main = "Histogram of Repayment Rate for 3
     year after entering repayment")
dev.off()


temp_Rpy5 <- college$COMPL_RPY_5YR_RT
temp_Rpy5[temp_Rpy5=='PrivacySuppressed'] = NA
Col_repay5 = as.numeric(temp_Rpy5)
Col_repay5_sumstat <- getSummary(Col_repay5)

png('images/histogram-Col-repay5.png')
hist(Col_repay5, xlab = "Rate", main = "Histogram of Repayment Rate for 5
     year after entering repayment")
dev.off()

#make pie-chart
print('plotting: piechart-repaymentRate.ong;')

png('images/piechart-repaymentRate.png')
Col_repay_piechart = c(mean(as.numeric(Col_repay3), na.rm = TRUE), mean(Col_repay5, na.rm = TRUE))
pie(Col_repay_piechart, labels = c('After 3 years', 'After 5 years'), radius = 1
    , main = 'Piechart for College Repayment Rate of Undergraduates')
dev.off()

barplot()

#Completion Rate 
C_rate <- college$C150_4
C_rate_sumstat <- getSummary(C_rate)

png('images/histogram-C-rate.png')
hist(C_rate, main = "Histogram of Completion Rate for 4-
     year after entering repayment")
dev.off()


# png('images/ggplot-schoolDistribution.png')
# p = ggplot()
# p = p + geom_polygon(data = all_states, 
#                      aes(x=long, y= lat, group = group), color = 'white')
# p = p + geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size = COSTT4_A),
#                    color = 'red') + scale_size(name = 'Average Cost of Attendance ')
# #p = p + geom_text(data = stateData, hjust = 0.5, vjust = -0.5, aes(x = LONGITUDE, y = LATITUDE, label = label), color = 'gold2', size = 4)
# p
# dev.off()

##
# Earning
YearMeanEarning_10 <- college$MN_EARN_WNE_P10
YearMedianEarning_10 <- as.numeric(college$MD_EARN_WNE_P10)

YearMedianEarning_10_table <- getSummary(YearMedianEarning_10)

png('images/histogram-YearMeanEarning_10.png')
hist(YearMedianEarning_10, xlab = "earning", main = 'Histogram of yearly mean earning of College students')
dev.off()

# Employment:
#dummy['10YearEmployment'] = as.numeric(college$COUNT_WNE_P10) / college$UGDS



# Proportion of Pell Grant
ProportionPellGrant <- as.numeric(college$PCTPELL)
ProportionPellGrant_table <- getSummary(ProportionPellGrant)

png('images/histogram-ProportionPellGrant.png')
hist(ProportionPellGrant, xlab = "proportion", main = "Histogram of Pell Grant proportion")
dev.off()

save(ProportionPellGrant_table, file = 'data/rData/table-ProportionPellGrant.RData')

#Percentage of first generation 
ProportionFirstGeneration <- college$FIRST_GEN


png('images/histogram-ProportionFirstGeneration.png')
hist(ProportionFirstGeneration, xlab = "proportion", main = "Histogram of proportions of first-generation undergraduates")
dev.off()

save(ProportionFirstGeneration_table)

temp = college$TUITIONFEE_IN
temp = college$TUITIONFEE_OUT
temp = college$TUITIONFEE_PROG


temp = college$INEXPFTE

#Plotting Rate vs. Rate

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

# Run analysis on variable `AVGFACSAL`, the average salary for faculty 

# Variables to observe: AVGFACSAL, MN_EARN_WNE_P*,MD_EARN_WNE_P*

# Summary Stats and histograms for Average Faculty Salary        

meanFacultySalary <- college$AVGFACSAL * 12
meanFacultySalary = meanFacultySalary[meanFacultySalary!=0]

# Ouput
meanFacultySalaryTable = getSummary(meanFacultySalary)
print('plotting: Average Faculty Salary')
save(meanFacultySalary, file = 'data/rData/table-meanFacultySalary.RData')
png('images/histogram-meanFacultySalary.png')
hist(meanFacultySalary, main = "Histogram of Average Faculty Salary", xlab = 'US Dollar per Year')
dev.off()

# Monthly saving 10 years after
# There seems to be something wrong with the data
# Decide not to use it
# tenYearEarning = college$MD_EARN_WNE_P10
# tenYearEarning[tenYearEarning == 'PrivacySuppressed'] = NA
# tenYearEarning = as.numeric(tenYearEarning[tenYearEarning != 0]) * 12




