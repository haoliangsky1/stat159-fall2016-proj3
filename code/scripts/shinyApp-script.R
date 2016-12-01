#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#setwd("C:/Users/andre/Dropbox/College/Fall 16/Stat159/stat159-fall2016-proj3")
library(ggplot2)
library(stringr)
library(shiny)

college = read.csv('../../data/schoolRanking.csv')
stateList = college$STABBR

ui = fluidPage(
  # This is the title
  titlePanel('Hello World'),
  
  # Main Panel
  mainPanel('Please add in some description so that the user can have a general idea of the project'),
  
  # Sidebar
  sidebarPanel('whatever you consider fit here'),
  
 
  fluidRow(
    column(2,
           # Select a state
           selectInput(inputId = 'state', label = 'Choose a State', choices = sort(stateList)),
           #plotOutput('plot'),
           # Select Race/Ethnicity
           selectInput("ethnicity", label = 'Choose Ethnicity',
                       choices = c('None','White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander')),
    )
  ),
  
	# First Generation
	radioButtons('firstGeneration', label = 'First Generation?', choices = c('Yes', 'No')),
	# Sex
	radioButtons('sex', label = 'Select Sex', choices = c('Male', 'Female')),
	# Select an intended major - Current list is placeholder
	selectInput(inputId = 'intendedMajor', label = 'Choose an intended major', 
	            choices = c('Computer Science','Literature','Mathematics','Engineering','Social Studies','Visual and Perfoming Arts','Business','History')),
	# Select financial aid level - Data has net cost after financial aid based on family income
	selectInput(inputId = 'familyIncome', label = 'Choose family income level', 
	            choices = c('$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+')),
	# Input SAT Scores - Data has percentiles of SAT/ACT scores for students
	numericInput('SATMath', label = 'Input SAT Math Score', value=NA),
	numericInput('SATCriticalReading', label = 'Input SAT Critical Reading Score', value = NA),
	numericInput('SATWriting', label = 'Input SAT Writing Score', value=NA),
	# Input ACT Scores
	numericInput('ACTEnglish', label = 'Input ACT English Score', value=NA),
	numericInput('ACTMath', label = 'Input ACT Math Score', value=NA),
	numericInput('ACTWriting', label = 'Input ACT Writing Score', value=NA)
	)

server = function(input, output) {
	output$scatterplot  = renderPlot({
		name = input$state
		})
}

shinyApp(ui = ui, server = server)



