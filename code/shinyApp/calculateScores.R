# This function calculates the Scores given the input of the user
library(microbenchmark)

calculateScores = function(dummy, income='$0-$30,000', firstGen=TRUE, major='None', SATCR=0, SATMT=0, ACTEN=0, ACTMT= 0, useDefaultWeights=FALSE) {
	if (useDefaultWeights == TRUE) {
		# weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2)
		# weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
		weight = c(-0.05, -0.05, -0.05, 0.1, 0.2, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1, -0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0, 0, 0, 0)
		} else {
			weight = rep(0, 26)
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

	# Major
	# Convert the test scores
	df$SATCR = handleScore(dummy, SATCR, 'SATCR')
	df$SATMT = handleScore(dummy, SATMT, 'SATMT')
	df$ACTEN = handleScore(dummy, ACTEN, 'ACTEN')
	df$ACTMT = handleScore(dummy, ACTMT, 'ACTMT')

	weight[23:26] = 0.1
	
	m = as.matrix(df[,9:ncol(df)])
	Score = rowSums(m %*% diag(weight), na.rm=T)
	
	Score = normalize(Score, 0, 100)
	Score = round(Score, 2)
	dummy['Score'] = Score
	return(dummy)
}

handleScore = function(df, studentScore, subject) {
	temp = c()
	if (subject == 'SATCR') {
		temp = df$SATCR
	} else if (subject == 'SATMT') {
		temp = df$SATMT
	} else if (subject == 'ACTEN') {
		temp = df$ACTEN
	} else if (subject == 'ACTMT') {
		temp = df$ACTMT
	}
	result = ifelse(temp <= studentScore, 1, -1)
	return(as.numeric(result))
}


centralization = function(df) {
	scaled = df[,]
	index = c(8:29)
	scaled[, index] = scale(df[, index], center = TRUE, scale = TRUE)
	return(scaled)
}


normalize = function(x, from=0, to=100) {
	(x - min(x, na.rm =T)) / max(x - min(x, na.rm=T), na.rm=T) * (to - from) + from
}