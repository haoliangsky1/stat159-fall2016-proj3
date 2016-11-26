# stat159-fall2016-proj3: 
# Need a title here

This repository holds the material for Project 3 of the fall 2016 edition of Statistics 159 at UC Berkeley by Liang Hao, Bret Hart, Andrew Shibata and Gary Nguyen.

This Project Repository contains multiple directories. 

The *code* folder contains:

* *functions* folder for self-defined functions;

* *scripts* folder for major R scripts used to produce the project, including Exploratory Data Analysis, Premodeling Data Processing;

* *tests* folder for the tests for self-defined functions.

More information about the codes for the project could be found in the *README.md* file in the *code* folder.

The *data* folder contains the major data set used for this project and all ther intermediate R data that are used to perform analysis and write the report. More information about the data could be found in the *README.md* file in the *data* folder.

The *images* folder contains all the images that are produced and used for analysis and report.

The *report* folder contains the *sections* folder, which stores the report by section, and the report for the analysis.

The *slides* folder contains all materials needed to produce the slides.


# Insturction for Reproduction:

To reproduce the project, only the skeleton of repository is necessary. All the materials and contents could be generated by *Makefile*.

## *Makefile* Commands:

The *Makefile* for this project provides multiple phony targets to streamline the reproduction process, including:

* ```all```: produce the entire project from scratch

* ```data```: will download the *Credit.csv* file to the folder *data*

* ```tests```: will run the unit tests for the self-defined functions

* ```eda```: will perform the exploratory data analysis

* ```report```: will generate the *report.pdf* file

* ```slides```: will generate the *slides.html*

* ```shinyApp```: will generate the shiny App for this project

* ```session```:  will generate the *session-info.txt* file

* ```clean```: will delete the generated report



```
stat159-fall2016-project2/
   README.md
   Makefile
   LICENSE
   session-info.txt
   .gitignore
   code/
      functions/
         ...
      scripts/
         ...
      tests/
         ...
   data/
      rawData/
         ...
      reducedData/
         ...
      rData/
         ...
   images/
      ...
   report/
      report.pdf
      report.Rmd
      sections/
         00-abstract.Rmd
         01-introduction.Rmd
         02-data.Rmd
         03-methods.Rmd
         04-analysis.Rmd
         05-results.Rmd
         06-conclusions.Rmd
   slides/
      ...
```


<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

Author: Liang Hao, Bret Hart, Andrew Shibata and Gary Nguyen
