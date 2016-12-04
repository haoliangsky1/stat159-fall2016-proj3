# This function calculates the Scores given the input of the user
library(microbenchmark)

calculateScores = function(dummy, income='$0-$30,000', firstGen=TRUE, useDefaultWeights=FALSE) {
	if (useDefaultWeights == TRUE) {
		weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2)
	} else {
	  weight = rep(0, 13)
	  if (income == '$0-$30,000') {
	    weight[1] = -0.5
	    } else if (income == '$30,001-$48,000') {
	      weight[2] = -0.5
	      } else if (income == '$48,001-$75,000') {
	        weight[3] = -0.5
	        } else if (income == '$75,001-$110,000') {
	          weight[4] = 0.5
	          } else if (income == '$110,000+') {
	            weight[5] = 0.5
	            }
	  # 3 year repayment rate
	  weight[6] = 0.1
	  # 5 year repyament rate
	  weight[7] = 0.1
	  # 4 year completion rate
	  weight[8] = 0.5
	  # 10 year mean earnings
	  weight[9] = 0.5
	  # 10 year median earnings
	  weight[10] = 0.5
	  # Pell Grant:
	  if (income == '$0-$30,000') {
	    weight[11] = 0.5
	    }
	  # Median debt
	  weight[12] = -0.1
	  # First generation
	  if (firstGen == TRUE) {
	    weight[13] = 0.2
	    }
	}
	# Centralization
	df = centralization(dummy)
	
	# for (i in 1:nrow(df)){
	# 	Score[i] = sum(weight * df[i, 8:ncol(df)])
	# }
	# Score = weight * df[, 8:ncol(df)]
	
	m = as.matrix(df[,9:ncol(df)])
	Score = rowSums(m %*% diag(weight), na.rm=T)
	
	Score = normalize(Score, 0, 100)
	Score = round(Score, 2)
	dummy['Score'] = Score
	return(dummy)
}

centralization = function(df) {
	scaled = df[,1:7]
	scaled[,8:ncol(df)] = scale(df[,8:ncol(df)], center = TRUE, scale = TRUE)
	return(scaled)
}


normalize = function(x, from=0, to=100) {
	(x - min(x, na.rm =T)) / max(x - min(x, na.rm=T), na.rm=T) * (to - from) + from
}