# Declare phony targets
.PHONY: all data clean tests eda report slides session

# Output
csv = data/*.csv
RData = data/*.RData
png = images/*.png
rnw = report/sections/*.Rnw

# PHONY targets
all: $(output)



data:
	# The All Data dataset
	curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	mv CollegeScorecard_Raw_Data.zip data/CollegeScorecard_Raw_Data.zip
	unzip data/CollegeScorecard_Raw_Data.zip -d data/rawData/

	# The Post-school earnings data set
	curl -O https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Treasury-Elements.csv
	mv Most-Recent-Cohorts-Treasury-Elements.csv data/reducedData/Most-Recent-Cohorts-Treasury-Elements.csv

	# Merge the data
	python code/function/cleanUp.py
	Rscript code/scripts/mergeData-script.R
	cp -b data/combinedData.csv code/shinyApp/combinedData.csv

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.R

eda:
	# perform the exploratory data analysis
	Rscript code/scripts/eda-script.R data/combinedData.csv


report: $(rnw)
	# concatinate the files into one
	#cat $(rnw) > report/report.Rnw
	# generate report.pdf
	Rscript -e "library(knitr); knit2pdf('report/report.Rnw', output = 'report/report.tex')"

shinyApp:
	Rscript code/script/makeDummyDataFrame-script.R data/combinedData.csv
	# generate the shinyApp for the project
	Rscript -e "shiny::runApp('code/shinyApp')"



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
	# rm -f data/rData/*.*
	# rm -f images/*.*
	# rm -f report/*.pdf
	