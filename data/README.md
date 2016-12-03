This folder contains the data used and generated in the production of this project.

* The *rawData*/ subdirectory previously contained the original full CollegeScoreCard dataset. Due to Github's limitation on upload size, we decided to remove it from the repository. Any user of this project is welcomed use the ```data``` command from the *Makefile* to download, unzip, and clean up the dataset. The command is commented out so that a user isn't forced to download such a large dataset accidentally if they already have it somewhere else on their computer. If you were to run the ```data``` command, it would extract the full set of spreadsheets to this subdirectory.

* The *reducedData*/ subdirectory contains the CSV files created in the cleaning process by the *cleanUp.py* in the project. For a more detailed description on the specific procedure of data cleaing, please refer to the *README.md* file in the *data* folder.

* The *rData* folder contains the *rData* objects generated in this project for the production of the report and the shinyApp.
