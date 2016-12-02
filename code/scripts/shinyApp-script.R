#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#setwd("C:/Users/andre/Dropbox/College/Fall 16/Stat159/stat159-fall2016-proj3")
library(ggplot2)
library(stringr)
library(shiny)

college = read.csv('../../data/schoolRanking.csv')
stateList = college$STABBR

shinyUI = fluidPage(
  # This is the title
  titlePanel('Custom College Match'),
  
  # Main Panel
  mainPanel('Custom Colllege Match finds the best schools for you to find the strongest schools for the best value.
             Based on your information we will show you the top 5 schools for you based on factors such as net price, completion rate, and average earnings after graduation.'),
  
  # Sidebar
  sidebarPanel('whatever you consider fit here'),
  
 
  fluidRow(
    column(3, h4('Basic Informaiton'), 
           selectInput(inputId = 'state', label = 'Choose a State', choices = sort(stateList)), br(),
           # Select Race/Ethnicity
           selectInput("ethnicity", label = 'Choose Ethnicity',
                       choices = c('None','White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander')),br(),
           # First Generation
           radioButtons('firstGeneration', label = 'First Generation?', choices = c('Yes', 'No')),br(),
           # Sex
           radioButtons('sex', label = 'Select Sex', choices = c('Male', 'Female')),br()
           ),
    column(3, h4('Intended Major'),
           # Select an intended major - Current list is placeholder
           selectInput(inputId = 'intendedMajor', label = 'Choose an intended major', 
                       choices = c('Computer Science','Literature','Mathematics','Engineering','Social Studies','Visual and Perfoming Arts','Business','History')),br()
           ),
    column(3, h4('Financial Aid'),
           # Select financial aid level - Data has net cost after financial aid based on family income
           selectInput(inputId = 'familyIncome', label = 'Choose family income level', 
                       choices = c('$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+')),br()
           ),
    column(3, h4('Standardized Test'),
           # Input SAT Scores - Data has percentiles of SAT/ACT scores for students
           numericInput('SATMath', label = 'Input SAT Math Score', value=NA),
           numericInput('SATCriticalReading', label = 'Input SAT Critical Reading Score', value = NA),
           numericInput('SATWriting', label = 'Input SAT Writing Score', value=NA),
           # Input ACT Scores
           numericInput('ACTEnglish', label = 'Input ACT English Score', value=NA),
           numericInput('ACTMath', label = 'Input ACT Math Score', value=NA),
           numericInput('ACTWriting', label = 'Input ACT Writing Score', value=NA)
           )
    ),
  submitButton("Submit")
  #plotOutput('plot'),
	)

shinyServer = function(input, output) {
	output$scatterplot  = renderPlot({
		name = input$state
		})
}

shinyApp(ui = shinyUI, server = shinyServer)



