# This function drops all the columns with too many 'PrivacySuppressed' and 'Null' or 'NaN'.
# The threshold used here

import pandas as pd
import numpy as np
# import os
# print(os.getcwd())

def getColumns(dataset, threshold=0.9):
    dataset.replace('PrivacvySuppressed', np.NaN)
    numOfRow = dataset.shape[0]
    nanList = dataset.isnull().sum().tolist()
    columnList = list(dataset.columns.values)
    colList = []
    for i in range(len(columnList)):
        column = columnList[i]
        if nanList[i] <= numOfRow * threshold:
            colList.append(column)
    return colList

def getRows(dataset, threshold=0.1):
    numOfRow = dataset.shape[0]
    numOfCol = dataset.shape[1]
    nanList = dataset.isnull().sum(axis=1).tolist()
    rowList = []
    schoolList = []
    idList = []
    for index, row in dataset.iterrows():
        if nanList[index] < numOfCol * threshold:
            rowList.append(index)
            schoolList.append(row['INSTNM'])
            idList.append(row['UNITID'])
    return set(idList)

raw11 = pd.read_csv('../../data/rawData/MERGED2010_11_PP.csv', sep=',', error_bad_lines=False, index_col=False, dtype='unicode')
print('read in raw data: 2011')
raw12 = pd.read_csv('../../data/rawData/MERGED2011_12_PP.csv', sep=',', error_bad_lines=False, index_col=False, dtype='unicode')
print('read in raw data: 2012')
raw13 = pd.read_csv('../../data/rawData/MERGED2012_13_PP.csv', sep=',', error_bad_lines=False, index_col=False, dtype='unicode')
print('read in raw data: 2013')
raw14 = pd.read_csv('../../data/rawData/MERGED2013_14_PP.csv', sep=',', error_bad_lines=False, index_col=False, dtype='unicode')
print('read in raw data: 2014')
raw15 = pd.read_csv('../../data/rawData/MERGED2014_15_PP.csv', sep=',', error_bad_lines=False, index_col=False, dtype='unicode')
print('read in raw data: 2015')
rawDataList = [raw11, raw12, raw13, raw14, raw15]
nameList = ['year11.csv', 'year12.csv','year13.csv','year14.csv','year15.csv']

# Use the newest data set of 20 as base for choosing columns
# thresholdColumn = 0.9
# columnList = getColumns(raw15, thresholdColumn)
columnList = ['UNITID', 'OPEID', 'INSTNM', 'STABBR', 'PREDDEG', 'HIGHDEG', 'CONTROL', 'ST_FIPS', 'REGION', 'LATITUDE', 'LONGITUDE', 'ADM_RATE', 'CCBASIC', 'CCUGPROF', \
'CCSIZSET', 'HBCU', 'PBI', 'ANNHI', 'TRIBAL', 'AANAPII', 'HSI','NANTI', 'SATVR25', 'SATVR75', 'SATMT25', 'SATMT75', 'SATVRMID', 'SATMTMID', 'SATWRMID', 'ACTCM25', 'ACTCM75', 'ACTEN25', 'ACTEN75', 'ACTMT25', 'ACTMT75', 'ACTCMMID', 'ACTENMID', 'ACTMTMID', 'ACTWRMID','SAT_AVG', \
'PCIP01', 'PCIP03', 'PCIP04', 'PCIP05', 'PCIP09', 'PCIP10','PCIP11','PCIP12','PCIP13', 'PCIP14', 'PCIP15', 'PCIP16', 'PCIP19', 'PCIP22', 'PCIP23','PCIP24','PCIP25','PCIP26','PCIP27','PCIP29', 'PCIP30', 'PCIP31', 'PCIP38', 'PCIP39', 'PCIP40', 'PCIP41', 'PCIP42', 'PCIP43', 'PCIP44', 'PCIP45', 'PCIP46', 'PCIP47', 'PCIP48', 'PCIP49', 'PCIP50', 'PCIP51', 'PCIP52', 'PCIP54', \
'CIP01BACHL', 'CIP03BACHL', 'CIP04BACHL', 'CIP05BACHL', 'CIP10BACHL', 'CIP11BACHL', 'CIP12BACHL', 'CIP13BACHL','CIP14BACHL', 'CIP15BACHL','CIP16BACHL','CIP19BACHL','CIP22BACHL','CIP23BACHL','CIP24BACHL','CIP25BACHL','CIP26BACHL','CIP27BACHL','CIP29BACHL','CIP30BACHL','CIP31BACHL','CIP38BACHL','CIP39BACHL','CIP40BACHL','CIP41BACHL','CIP42BACHL','CIP43BACHL','CIP44BACHL','CIP45BACHL','CIP46BACHL','CIP47BACHL','CIP48BACHL','CIP49BACHL','CIP50BACHL','CIP51BACHL','CIP52BACHL','CIP54BACHL',\
'DISTANCEONLY', 'UGDS', 'UGDS_WHITE', 'UGDS_BLACK', 'UGDS_HISP', 'UGDS_ASIAN', 'UGDS_AIAN', 'UGDS_NHPI', 'UGDS_2MOR', 'UGDS_NRA','UGDS_UNKN','PPTUG_EF', 'CURROPER', 'NPT4_PUB', 'NPT4_PRIV', 'NPT41_PUB', 'NPT42_PUB', 'NPT43_PUB', 'NPT44_PUB', 'NPT45_PUB', 'NPT41_PRIV', 'NPT42_PRIV', 'NPT43_PRIV', 'NPT44_PRIV', 'NPT45_PRIV', 'NPT4_048_PUB', 'NPT4_048_PRIV', 'NPT4_3075_PUB', 'NPT4_3075_PRIV', 'NPT4_75UP_PUB', 'NPT4_75UP_PRIV', 'NUM4_PUB', 'NUM4_PRIV', 'NUM41_PUB', 'NUM42_PUB', 'NUM43_PUB', 'NUM44_PUB', 'NUM45_PUB',\
 'NUM41_PRIV', 'NUM42_PRIV', 'NUM43_PRIV', 'NUM44_PRIV', 'NUM45_PRIV', 'COSTT4_A', 'COSTT4_P', 'TUITIONFEE_IN', 'TUITIONFEE_OUT', 'TUITIONFEE_PROG',  'TUITFTE', 'INEXPFTE', 'AVGFACSAL', 'PFTFAC', 'PCTPELL', \
 'C150_4','C150_L4', 'C150_4_POOLED', 'C150_L4_POOLED', 'PFTFTUG1_EF', 'D150_4', 'D150_L4', 'D150_4_POOLED',  'D150_L4_POOLED', 'C150_4_WHITE', 'C150_4_BLACK', 'C150_4_HISP', 'C150_4_ASIAN', 'C150_4_AIAN', 'C150_4_2MOR', 'C150_4_NRA', 'C150_4_UNKN','C150_L4_WHITE', 'C150_L4_BLACK', 'C150_L4_HISP', 'C150_L4_ASIAN', 'C150_L4_AIAN', 'C150_L4_2MOR', 'C150_L4_NRA', 'C150_L4_UNKN', \
 'C200_4', 'C200_L4','D200_4','D200_L4', 'RET_FT4', 'RET_FTL4','RET_PT4','RET_PTL4', 'C200_4_POOLED','C200_L4_POOLED','D200_4_POOLED','D200_L4_POOLED', \
 'PCTFLOAN', 'CDR3', \
 'RPY_3YR_RT', 'COMPL_RPY_3YR_RT','NONCOM_RPY_3YR_RT','LO_INC_RPY_3YR_RT', 'MD_INC_RPY_3YR_RT', 'HI_INC_RPY_3YR_RT', 'DEP_RPY_3YR_RT', 'IND_RPY_3YR_RT', 'PELL_RPY_3YR_RT', 'NOPELL_RPY_3YR_RT', 'FEMALE_RPY_3YR_RT', 'MALE_RPY_3YR_RT', 'FIRSTGEN_RPY_3YR_RT', 'NOTFIRSTGEN_RPY_3YR_RT', \
 'RPY_5YR_RT', 'COMPL_RPY_5YR_RT','NONCOM_RPY_5YR_RT','LO_INC_RPY_5YR_RT', 'MD_INC_RPY_5YR_RT', 'HI_INC_RPY_5YR_RT', 'DEP_RPY_5YR_RT', 'IND_RPY_5YR_RT', 'PELL_RPY_5YR_RT', 'NOPELL_RPY_5YR_RT', 'FEMALE_RPY_5YR_RT', 'MALE_RPY_5YR_RT', 'FIRSTGEN_RPY_5YR_RT', 'NOTFIRSTGEN_RPY_5YR_RT', \
 'RPY_7YR_RT', 'COMPL_RPY_7YR_RT','NONCOM_RPY_7YR_RT','LO_INC_RPY_7YR_RT', 'MD_INC_RPY_7YR_RT', 'HI_INC_RPY_7YR_RT', 'DEP_RPY_7YR_RT', 'IND_RPY_7YR_RT', 'PELL_RPY_7YR_RT', 'NOPELL_RPY_7YR_RT', 'FEMALE_RPY_7YR_RT', 'MALE_RPY_7YR_RT', 'FIRSTGEN_RPY_7YR_RT', 'NOTFIRSTGEN_RPY_7YR_RT', \
 'DEP_INC_AVG','IND_INC_AVG', 'DEBT_MDN', 'GRAD_DEBT_MDN', 'LO_INC_DEBT_MDN','MD_INC_DEBT_MDN', 'HI_INC_DEBT_MDN','DEP_DEBT_MDN', 'IND_DEBT_MDN', 'PELL_DEBT_MDN', 'NOPELL_DEBT_MDN','FEMALE_DEBT_MDN','MALE_DEBT_MDN','FIRSTGEN_DEBT_MDN', 'NOTFIRSTGEN_DEBT_MDN', 'DEBT_N', 'GRAD_DEBT_N', 'LO_INC_DEBT_N', 'MD_INC_DEBT_N', 'HI_INC_DEBT_N', 'DEP_DEBT_N','IND_DEBT_N', 'PELL_DEBT_N', 'NOPELL_DEBT_N', 'FEMALE_DEBT_N', 'MALE_DEBT_N', 'FIRSTGEN_DEBT_N','NOTFIRSTGEN_DEBT_N', 'GRAD_DEBT_MDN10YR', 'CUML_DEBT_N',  'CUML_DEBT_P90', 'CUML_DEBT_P75', 'CUML_DEBT_P25', 'CUML_DEBT_P10', \
 'INC_N', 'DEP_INC_N', 'IND_INC_N', 'DEP_STAT_N', 'PAR_ED_N','PAR_ED_PCT_1STGEN', 'ICLEVEL', 'completion_rate_4yr_100nt', 'completion_cohort_4yr_100nt', 'FIRST_GEN', 'PAR_ED_PCT_1ST_GEN'] 

# print('This is the number of columns that we use with a NaN threshold of: ' + str(thresholdColumn))
print('This is the number of columns choosed:')
print(len(columnList))
reducedColumnData = []

for i in range(len(rawDataList)):
    temp = rawDataList[i]
    temp.replace('PrivacvySuppressed', np.NaN)
    reduced = temp[columnList]
    reducedColumnData.append(reduced)

# Use the intersection of rows to choose rows
rowListSet = []
thresholdRow = 0.9
rowSet11 = getRows(reducedColumnData[0], thresholdRow)
rowSet12 = getRows(reducedColumnData[1], thresholdRow)
rowSet13 = getRows(reducedColumnData[2], thresholdRow)
rowSet14 = getRows(reducedColumnData[3], thresholdRow)
rowSet15 = getRows(reducedColumnData[4], thresholdRow)
rowList = set.intersection(rowSet11, rowSet12, rowSet13, rowSet14, rowSet15)
print('This is number of school OPEID that we use with a NaN threshold of: ' + str(thresholdRow))
print(len(rowList))

reducedDataList = []
for i in range(len(reducedColumnData)):
    df = reducedColumnData[i]
    temp = df.loc[df['UNITID'].isin(rowList)]
    reducedDataList.append(temp)

# Output supportive dataset
path = '../../data/reducedData/'
for i in range(len(reducedDataList)):
    filename = path + nameList[i]
    temp = reducedDataList[i]
    temp.to_csv(filename)
    print(nameList[i] + ' converted.')


salaryRaw = pd.read_csv('../../data/reducedData/Most-Recent-Cohorts-Treasury-Elements.csv')
salaryRaw.replace('PrivacvySuppressed', np.NaN)
salary = salaryRaw.loc[df['UNITID'].isin(rowList)]
salary.to_csv(path + 'salaryRaw.csv')
print('salaryRaw.csv' + ' converted.')


