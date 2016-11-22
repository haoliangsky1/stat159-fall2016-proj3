# This is the file for Exploratory Data Analysis 
# of the dataset for the project

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

# By state:
stateTable=count(college, 'STABBR')
