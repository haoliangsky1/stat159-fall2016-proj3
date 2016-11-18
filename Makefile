# Declare phony targets
.PHONY: all data clean tests eda report slides session

# Output



# PHONY targets
all: $(output)



data:
	curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	mv CollegeScorecard_Raw_Data.zip rawData/CollegeScorecard_Raw_Data.zip
	unzip rawData/CollegeScorecard_Raw_Data.zip
	python code/function/cleanUp.pyt



session:
	# Generate session info for the environment
	# bash session.sh
	# Rscript code/scripts/session-info-script.R

clean:
	# Clean 
	# rm -f session-info.txt
	# rm -f data/*.csv
	# rm -f images/*.*
	# rm -f report/*.pdf
	