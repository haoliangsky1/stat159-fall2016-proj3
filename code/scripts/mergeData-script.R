#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
year11 = read.csv('../../data/reducedData/year11.csv')
year11 = year11[,2:ncol(year11)]
year12 = read.csv('../../data/reducedData/year12.csv')
year12 = year12[,2:ncol(year12)]
year13 = read.csv('../../data/reducedData/year13.csv')
year13 = year13[,2:ncol(year13)]
year14 = read.csv('../../data/reducedData/year14.csv')
year14 = year14[,2:ncol(year14)]
year15 = read.csv('../../data/reducedData/year15.csv')
year15 = year15[,2:ncol(year15)]

mergeCell = function(a, b, c, d, e) {
  vector = c(a,b,c,d,e)
  weight = c(0.4, 0.3, 0.2, 0.05, 0.05)
  weightedVector = vector * weight
  adjustedWeight = weight[-which(is.na(weightedVector))]
  if (sum(weightedVector, na.rm = T) == 0) {
    numerator = 0
  } else {
    numerator = sum(weightedVector, na.rm = T)
  }
  if (sum(adjustedWeight) == 0) {
    denominator = 1.0
  } else {
    denominator = sum(adjustedWeight)
  }
  return (numerator / denominator)
}

dataList = c(year15, year14, year13, year12, year11)
combinedData = data.frame()

for (row in 1:nrow(year15)) {
  for (col in 1:ncol(year15)) {
    if (class(year15[row, col]) == "integer"  || class(year15[row, col]) == "numeric" ){
      combinedData[row, col] = mergeCell(year15[row, col], year14[row, col], year13[row, col], year12[row, col], year11[row, col])
    } else if (class(year15[row, col]) == "factor") {
      combinedData[row, col] = year15[row, col]
    } 
  } 
  if (row %% 100 == 0) {
    print(row)
  }
}

colnames(combinedData) = colnames(year15)
write.csv(combinedData, file = '../../data/combinedYearData.csv')
temp = combinedData[,-2]

salaryRaw = read.csv('../../data/reducedData/salaryRaw.csv')
salary = salaryRaw[salaryRaw$UNITID %in% year15$UNITID,]
output = merge(temp, salary, by = c('UNITID', 'INSTNM'))
write.csv(output, file = '../../data/combinedData.csv')
