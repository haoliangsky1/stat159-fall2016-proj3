# Declare phony targets
.PHONY: all data clean tests eda report slides session

# Output
rmd = report/sections/*.Rmd


# PHONY targets
all: $(output)



data:
	curl -O https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip
	mv CollegeScorecard_Raw_Data.zip data/CollegeScorecard_Raw_Data.zip
	unzip data/CollegeScorecard_Raw_Data.zip -d data/rawData/
	python code/function/cleanUp.py

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.
	# generate report.pdf
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'


report:
	# concatinate the files into one
	cat$(rmd) > report/report.Rmd

shinyApp:
	# generate the shinyApp for the project


slides:
	# generate the slides.thml


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
	