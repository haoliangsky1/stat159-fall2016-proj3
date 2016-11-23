# This is the file for Exploratory Data Analysis 
# of the dataset for the project

#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#college = read.csv('data/combinedData.csv')
library(plyr)
library(maps)
library(ggplot2)
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
png('images/ggplot-schoolDistribution.png')
p = ggplot()
p = p + geom_polygon(data = all_states, 
                     aes(x=long, y= lat, group = group), color = 'white')
p = p + geom_point(data = stateData, aes(x = LONGITUDE, y = LATITUDE, size = UGDS),
                   color = 'red') + scale_size(name = 'Undergraduate Enrollment ')
#p = p + geom_text(data = stateData, hjust = 0.5, vjust = -0.5, aes(x = LONGITUDE, y = LATITUDE, label = label), color = 'gold2', size = 4)
p
dev.off()


## Admission Rate, We may use 40% as threshold
temp = year15[year15$UNITID %in% college$UNITID, ]
temp = temp[temp$STABBR %in% stateList, ]
admissionData =  temp[!is.na(temp$ADM_RATE), ]
admissionData = admissionData[admissionData$ADM_RATE < 0.4, ]
# Output as plot
png('images/ggplot-admissionRateDistribution.png')
p = ggplot()
p = p + geom_polygon(data = all_states, 
                     aes(x=long, y= lat, group = group), color = 'white')
p = p + geom_point(data = admissionData, aes(x = LONGITUDE, y = LATITUDE, size = 1-ADM_RATE),
                   color = 'red') + scale_size(name = 'Undergraduate Rejection Rate')
#p = p + geom_text(data = stateData, hjust = 0.5, vjust = -0.5, aes(x = LONGITUDE, y = LATITUDE, label = label), color = 'gold2', size = 4)
p
dev.off()


# Flag for Historically Black College and University
HBCUTable = count(college, 'HBCU')

# Flag for predominantly black institution
PBITable = count(college, 'PBI')

# Flag for Alaska Native Hawaiian serving institution
ANNHITable = count(college, 'ANNHI')

# Flag for tribal college and university
TRIBALTable = count(college, 'TRIBAL')

# Flag for Asian American Native American PacificIslander-serving institution
AANAPIITable = count(college, 'AANAPII')

# Flag for Hispanic-serving institution
HSITable = count(college, 'HSI')


# Entrance Test Score Summary
# SAT
SATCR = college$SATVRMID
SATCR = SATCR[SATCR != 0]
hist(SATCR, main = 'Histogram of Median of SAT Critical Reading Scores')
length(SATCR)

SATMT = college$SATMTMID
SATMT = SATMT[SATMT != 0]
hist(SATMT, main = 'Histogram of Median of SAT Math Scores')
length(SATMT)

SATWR = college$SATWRMID
SATWR = SATWR[SATWR != 0]
hist(SATWR, main = 'Histogram of Meidan of SAT Writing Scores')

# ACT
ACTEN = college$ACTENMID
ACTEN = ACTEN[ACTEN != 0]
hist(ACTEN, main = 'Histogram of Median of ACT English')
length(ACTEN)

ACTMT = college$ACTMTMID
ACTMT = ACTMT[ACTMT != 0]
hist(ACTMT, main = 'Histogram of Median of ACT Math')
length(ACTMT)

ACTWR = college$ACTWRMID
ACTWR = ACTWR[ACTWR != 0]
hist(ACTWR, main = 'Histogram of Median of ACT Writing')
length(ACTWR)

# Need criteria for good school
# Salary?
# Entrance SAT?

# Financial support?


