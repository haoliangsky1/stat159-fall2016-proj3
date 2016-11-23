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
stateData = year15[year15$UNITID %in% college$UNITID, c(2:5, 10:12, 117)]
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


## Admission Rate, We may use 30% as threhold
temp = year15[year15$UNITID %in% college$UNITID, c(1:5, 10:13, 117)]
admissionData =  temp[(temp$ADM_RATE < 0.3), ]

# Need criteria for good school
# Salary?
# Entrance SAT?

# Financial support?




