library(stringr)
library(shiny)
library(plyr)
library(maps)
library(ggplot2)
library(grDevices)
library(leaflet)
library(DT)

#source('../functions/plotGeo.R')
source('../functions/makeTable.R')

dummyScore = read.csv('../../data/schoolRanking.csv')
college = read.csv('../../data/combinedData.csv')

# Preparing data for the ggplot:
stateList = college$STABBR
all_states = map_data('state')
all_states[]

# Define UI for the application 
ui = fluidPage(
  # This is the title
  titlePanel('Custom College Match'),
  
  # Main Panel
  mainPanel(h1('Introduction'),
            p('Custom Colllege Match finds the best schools for you to find the strongest schools for the best value.
            Based on your information we will show you the top 5 schools for you based on factors such as net price, completion rate, and average earnings after graduation.'),
            br(),
            br(),
            img(src = 'ggplot-schoolDistribution.png')
            ),
  
  # Sidebar
  sidebarPanel('whatever you consider fit here'),
  
  
  fluidRow(
    column(3, h4('Basic Informaiton'), 
           selectInput(inputId = 'state', label = 'Choose a State', choices = sort(stateList), selected = 'None'), br(),
           # Select Race/Ethnicity
           selectInput(inputId = "ethnicity", label = 'Choose Ethnicity',
                       choices = c('White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander'), 
                       selected= 'None'),
           br(),
           # First Generation
           radioButtons(inputId = 'firstGeneration', label = 'First Generation?', choices = c('Yes', 'No')),br(),
           # Sex
           radioButtons(inputId = 'sex', label = 'Select Sex', choices = c('Male', 'Female')),br()
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
           numericInput(inputId = 'SATMath', label = 'Input SAT Math Score', value=NA),
           numericInput(inputId = 'SATCriticalReading', label = 'Input SAT Critical Reading Score', value = NA),
           #numericInput(inputId = 'SATWriting', label = 'Input SAT Writing Score', value=NA),
           # Input ACT Scores
           numericInput(inputId = 'ACTEnglish', label = 'Input ACT English Score', value=NA),
           numericInput(inputId = 'ACTMath', label = 'Input ACT Math Score', value=NA)
           #numericInput(inputId = 'ACTWriting', label = 'Input ACT Writing Score', value=NA)
    )
  ),
  actionButton("action", label= 'Go'),
  br(),
  fluidRow(
    DT::dataTableOutput('table')
  ),
  br()
  )
# Define server logic required to draw a histogram
server = function(input, output) {
  
  output$plot = renderPlot({
    stateName = input$state
    #plotGeo(stateName, dummyScore)
    #tags$div(img(src = 'choiceOfState.png'))
    
  })
  output$table = DT::renderDataTable(DT::datatable({
    stateName = input$state
    ethnicity = input$ethnicity
    income = input$familyIncome
    SATMath = input$SATMath
    SATCR = input$SATCriticalReading
    ACTEng = input$ACTEnglish
    ACTMath = input$ACTMath
    #table = makeTable(dummyScore, stateName, ethnicity, income, SATMath, SATCR, ACTEng, ACTMath)
    table = matrix(1,1)
  }))
  
  
  
  # First make a graph of the choice of state:
  #output$plot  = renderPlot({
  #  stateName = input$state
  #	})
}

# Run the application 
shinyApp(ui = ui, server = server)

