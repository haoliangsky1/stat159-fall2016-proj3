# Declare phony targets
.PHONY: all data clean tests eda report slides session shinyApp 

# Output
csv = data/*.csv
RData = data/rData/*.RData
png = images/*.png
rnw = report/sections/*.Rnw
log = report/*.log
shiny = code/shinyApp/*

output = $(csv) $(RData) $(png) $(log) session-info.txt report/report.pdf $(shiny)
# PHONY targets
all: $(output)

report/report.pdf:
	Rscript -e "library(knitr); knit2pdf('report/report.Rnw', output = 'report/report.tex')"

session-info.txt: session.sh
	bash session.sh
	Rscript code/scripts/session-info-script.R

data/rData/*.RData:
	Rscript code/scripts/eda-script.R data/combinedData.csv
	Rscript code/scripts/makeDummyDataFrame-script.R data/combinedData.csv

images/*.png:
	Rscript code/scripts/eda-script.R data/combinedData.csv

data/rawData/*.csv:
	# Commented out for reproducibility
	# curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	# mv CollegeScorecard_Raw_Data.zip data/CollegeScorecard_Raw_Data.zip
	# unzip data/CollegeScorecard_Raw_Data.zip -d data/rawData/

data/reducedData/*.csv:
	# curl -O https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Treasury-Elements.csv
	# mv Most-Recent-Cohorts-Treasury-Elements.csv data/reducedData/Most-Recent-Cohorts-Treasury-Elements.csv

$(csv):
	# python code/function/cleanUp.py
	# Rscript code/scripts/mergeData-script.R
	# cp -b data/combinedData.csv code/shinyApp/combinedData.csv

	# Rscript code/script/makeDummyDataFrame-script.R data/combinedData.csv



# Phony targets:
data:

	# The codes for this session are commented out because the original data files are too large
	# Anyone pulling the the repo would find all data files necessary for this project already in data/ folder



	# The All Data dataset:

	# curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	# mv CollegeScorecard_Raw_Data.zip data/CollegeScorecard_Raw_Data.zip
	# unzip data/CollegeScorecard_Raw_Data.zip -d data/rawData/

	# The Post-school earnings data set:

	# curl -O https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Treasury-Elements.csv
	# mv Most-Recent-Cohorts-Treasury-Elements.csv data/reducedData/Most-Recent-Cohorts-Treasury-Elements.csv

	# Merge the data:

	# python code/function/cleanUp.py
	# Rscript code/scripts/mergeData-script.R
	# cp -b data/combinedData.csv code/shinyApp/combinedData.csv

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.R

eda:
	# perform the exploratory data analysis
	Rscript code/scripts/eda-script.R data/combinedData.csv


report: 
	# concatinate the files into one
	#cat $(rnw) > report/report.Rnw
	# generate report.pdf
	Rscript -e "library(knitr); knit2pdf('report/report.Rnw', output = 'report/report.tex')"
	rm $(log)

shinyApp:
	Rscript code/scripts/makeDummyDataFrame-script.R data/combinedData.csv
	# generate the shinyApp for the project
	Rscript -e "shiny::runApp('code/shinyApp')"
	# Rscript -e "shiny::deployApp('code/shinyApp')"



slides:
	# generate the slides.html
	Rscript -e 'library(rmarkdown); render("slides/slides.Rmd")'



session:
	# Generate session info for the environment
	bash session.sh
	Rscript code/scripts/session-info-script.R

clean:
	# Clean up files
	# rm -f data/*.csv
	rm -f data/rData/*.*
	rm -f images/*.*
	rm -f session-info.txt
	rm -f report/*.pdf
	