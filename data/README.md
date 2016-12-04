This folder contains the data used and generated in the production of this project.

* The *rawData*/ subdirectory previously contained the original full CollegeScoreCard dataset. Due to Github's limitation on upload size, we decided to remove it from the repository. Any user of this project is welcomed use the ```data``` command from the *Makefile* to download, unzip, and clean up the dataset. The command is commented out so that a user isn't forced to download such a large dataset accidentally if they already have it somewhere else on their computer. If you were to run the ```data``` command, it would extract the full set of spreadsheets to this subdirectory.

* The *reducedData*/ subdirectory contains the CSV files created in the cleaning process by the *cleanUp.py* in the project. To see the actual scripts that carried out this process, please refer to the python and R scripts in the *code* folder.

* The *rData* folder contains the *rData* objects generated in this project for the production of the report and the shinyApp.

This data comes from the US Department of Education College Scorecard (https://collegescorecard.ed.gov/data/). We decided to only include data from the 5 most recent years because school profiles may fluctuate rapidly with regards to admissions and tuition requirements. 

* *combinedData* takes the most recent years' data and consolidates them into one dataset. 

* *combinedYearData* does not include salary information.

* *schoolRanking* is a greatly reduced file with relevant variables used to calculate scores and is dynamically modified by the app.