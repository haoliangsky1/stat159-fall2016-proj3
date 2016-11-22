# Declare phony targets
.PHONY: all data clean tests eda report slides session

# Output
rmd = report/sections/*.Rmd


# PHONY targets
all: $(output)



data:
	# The All Data dataset
	curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	mv CollegeScorecard_Raw_Data.zip data/CollegeScorecard_Raw_Data.zip
	unzip data/CollegeScorecard_Raw_Data.zip -d data/rawData/
	python code/function/cleanUp.py

	# The Post-school earnings data set
	curl -O https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Treasury-Elements.csv
	mv Most-Recent-Cohorts-Treasury-Elements.csv data/reducedData/Most-Recent-Cohorts-Treasury-Elements.csv

	# Merge the data
	Rscript code/scripts/mergeData-script.R

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.
	# generate report.pdf
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'

eda:
	# perform the exploratory data analysis
	Rscript code/scripts/eda-script.R data/combinedData.csv


report:
	# concatinate the files into one
	cat$(rmd) > report/report.Rmd

shinyApp:
	# generate the shinyApp for the project


slides:
	# generate the slides.html
	Rscript -e 'library(rmarkdown); render("slides/slides.Rmd")'



session:
	# Generate session info for the environment
	bash session.sh
	Rscript code/scripts/session-info-script.R

clean:
	# Clean 
	# rm -f session-info.txt
	# rm -f data/*.csv
	# rm -f images/*.*
	# rm -f report/*.pdf
	