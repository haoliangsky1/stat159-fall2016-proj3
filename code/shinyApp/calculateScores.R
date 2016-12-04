# This function calculates the Scores given the input of the user
library(microbenchmark)

calculateScores = function(dummy, income='$0-$30,000', firstGen=TRUE, major='None', useDefaultWeights=FALSE) {
	if (useDefaultWeights == TRUE) {
		# weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2)
		weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
	} else {
	  # weight = rep(0, 13)
	  weight = rep(0, 22)
	  if (income == '$0-$30,000') {
	    weight[1] = -0.3
	    } else if (income == '$30,001-$48,000') {
	      weight[2] = -0.3
	      } else if (income == '$48,001-$75,000') {
	        weight[3] = -0.3
	        } else if (income == '$75,001-$110,000') {
	          weight[4] = 0.4
	          } else if (income == '$110,000+') {
	            weight[5] = 0.4
	            }
	  # 3 year repayment rate
	  weight[6] = 0.1
	  # 5 year repyament rate
	  weight[7] = 0.1
	  # 4 year completion rate
	  weight[8] = 0.8
	  # 10 year mean earnings
	  weight[9] = 0.8
	  # 10 year median earnings
	  weight[10] = 0.8
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

	  #Intended Major
	  if (major == 'None') {
	    weight[14:22] = 0.1
	    } else if (major == 'Computer Science') {
	      weight[14] = 0.3
	      } else if (major == 'Literature') {
	        weight[15] = 0.3
	        } else if (major == 'Mathematics/Statistics'){
	          weight[16] = 0.3
	          } else if (major == 'Engineering') {
	            weight[17] = 0.3
	            } else if (major == 'Social Studies/Humanities') {
	              weight[18] = 0.3
	              } else if (major == 'Visual and Performing Arts') {
	                weight[19] = 0.3
	                } else if (major == 'Business') {
	                  weight[20] = 0.3
	                  } else if (major == 'History') {
	                    weight[21] = 0.3
	                    } else if (major == 'Life Science/Health') {
	                      weight[22] = 0.3
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