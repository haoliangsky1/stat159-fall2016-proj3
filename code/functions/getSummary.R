# Compute the summary statistics for quantitative variables
getSummary = function(vector){
  temp = matrix(nrow = 1, ncol = 9, byrow= T)
  temp[1,] = c(min(vector, na.rm=T), max(vector, na.rm=T), (max(vector, na.rm=T) - min(vector, na.rm=T)), median(vector, na.rm=T), quantile(vector, na.rm=T)[[2]], quantile(vector, na.rm=T)[[4]], IQR(vector, na.rm=T), mean(vector, na.rm=T),sd(vector, na.rm=T))
  colnames(temp) = c('Min.', 'Max.', 'Range', 'Median', '25th', '75th', 'IQR', 'Mean', 'SD')
  return(temp)
}

