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
dummy['3YearRepay'] = college$COMPL_RPY_3YR_RT
dummy['5YearRepay'] = college$COMPL_RPY_5YR_RT
dummy['7YearRepay'] = college$COMPL_RPY_7YR_RT

# We only take 4-year institute
dummy = dummy[dummy$HIGHDEG == 4,]




'MEDIAN_HH_INC', 'POVERTY_RATE', 'COUNT_NWNE_P10', 'COUNT_WNE_P10', 'MN_EARN_WNE_P10', 'MD_EARN_WNE_P10', 'PCT25_EARN_WNE_P10', 'PCT75_EARN_WNE_P10','SD_EARN_WNE_P10', 'COUNT_WNE_INC1_P10', 'COUNT_WNE_INC2_P10', 'COUNT_WNE_INC3_P10', 'GT_25K_P10', 'GRAD_DEBT_MDN_SUPP', 'COMPL_RPY_3YR_RT_SUPP', 'FIRSTGEN_RPY_3YR_RT_SUPP', 'NOTFIRSTGEN_RPY_3YR_RT_SUPP' 


# Standardization