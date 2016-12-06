Welcome to the code/ directory. This folder contains the code that is used in the production of this project.

The *functions*/ subdirectory contains the python scripts for parsing and cleaning the raw college scorecard dataset. Any users of this project are welcome to add any scripts that they desire for any purpose.

The *scripts*/ subdirectory contains:

* *eda-script.R* carries out Exploratory Data Analysis (EDA) on the data to gain a semblance of understanding - including:

    - Calculating the summary statistics

    - Drawing histograms, piecharts, and boxplots

    - Creating frequency tables

    - And various other exploratory activities.

* *mergeData-script.R* merges the dataset parsed by the python code mentioned above. It takes in the last five years of data for educational institutions and the post graduation salary dataset, returning a merged dataset.

* *session-info-script.R* prints the session information and environment for this project, including all R packages used for this project.

* *shinyApp-script.R* generates the shinyApp for this project.

The *shinyApp*/ subdirectory contains:

* *app.R* is the central script for generating the Shiny App. It defines the UI for the application and utilizes the helper functions (described below) to return a list of recommended colleges. 

* *calculateScores.R* is a helper function that calculates the scores for colleges based on predictors as noted in commented code. This script determines the weights for the various predictors.

* *makeRankingTable.R* is a helper function that creates a table with relevant information to display for the recommended schools.

* *plotGeo.R* is a helper function that plots the locations of recommended universities of a given state.

* *makeSchoolTable.R* is a helper function that returns a list of essential information that the user may be interested in.

* *rsconnect* folder contains the structure necessary for shinyApp publishing.

* *www* folder contains a few plots that could be used in the shinyApp. Users are welcome to add in anything interesting.

The *tests*/ subdirectory contains the unit tests for the self-defined functions. 

