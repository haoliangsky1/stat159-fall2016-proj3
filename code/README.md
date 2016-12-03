Welcome to the code/ directory. This folder contains the code that is used in the production of this project.

The *functions*/ subdirectory contains the python scripts for parsing and cleaning the raw college scorecard dataset. Any users of this project are welcome to add any scripts that they desire for any purpose.

The *scripts*/ subdirectory contains:

* *eda-script.R* carries out Exploratory Data Analysis (EDA) on the data to gain a semblance of understanding - including:

    -  Calculating the summary statistics

    - Drawing histograms, piecharts, and boxplots

    - Creating frequency tables

    - And various other exploratory activities.

* *mergeData-script.R* merges the dataset parsed by the python code mentioned above. It takes in the last five years of data for educational institutions and the post graduation salary dataset, returning a merged dataset.

* *session-info-script.R* prints the session information and environment for this project, including all R packages used for this project.

* *shinyApp-script.R* generates the shinyApp for this project.
