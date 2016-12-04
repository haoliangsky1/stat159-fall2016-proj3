library(stringr)
library(shiny)
library(plyr)
library(maps)
library(ggplot2)
library(grDevices)
library(leaflet)
library(DT)

source('plotGeo.R')
source('makeRankingTable.R')
source('makeSchoolTable.R')
source('calculateScores.R')


dummy = read.csv('schoolRanking.csv')
dummyScore = calculateScores(dummy, useDefaultWeights=TRUE)
college = read.csv('combinedData.csv')

# Preparing data for the ggplot:
stateList = c('AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'ID', 'IL', 'IN','IA','KS', 'KY','LA','ME','MD','MA','MI','MN','MS','MO','MT', 'NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')

all_states = map_data('state')


# Define UI for the application 
ui = fluidPage(
  # This is the title
  titlePanel('Custom College Match'),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      h4('Map for all educational institutions in the recommendation system'),
      plotOutput('mapNational')
      
    ),
    
    mainPanel(
      h1('Introduction'),
      helpText('Custom Colllege Match finds the best schools for you to find the strongest schools for the best value.
               Based on your information we will show you the top 10 schools for you based on factors such as net price, completion rate, and average earnings after graduation.'),
      fluidRow(
        column(5, h4('Basic Informaiton'), 
               # take out states like AS
               selectInput(inputId = 'state', label = 'Choose a State', choices = c('None', stateList), selected = 'None'),
               # Select Race/Ethnicity
               selectInput(inputId = "ethnicity", label = 'Choose Ethnicity',
                           choices = c('None','White', 'Black or African American', 'Hispanic', 'Asian', 'American Indian/Alaska Native', 'Native Hawaiian/Pacific Islander'), 
                           selected= 'None')
      ),
      column(5, h4('Financial Aid'),
             # Select financial aid level - Data has net cost after financial aid based on family income
             selectInput(inputId = 'familyIncome', label = 'Choose family income level', 
                         choices = c('None','$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+'), selected = 'None'),
             br(),
             h4('Intended Major'),
             # Select an intended major - Current list is placeholder
             selectInput(inputId = 'intendedMajor', label = 'Choose an intended major', 
                         choices = c('None','Computer Science','Literature','Mathematics','Engineering','Social Studies','Visual and Perfoming Arts','Business','History'), selected = 'None')
        
      )
    ),
    fluidRow(
      column(5, h4('Standardized Test'),
             # Input SAT Scores - Data has percentiles of SAT/ACT scores for students
             numericInput(inputId = 'SATMath', label = 'Input SAT Math Score', value=NA),
             numericInput(inputId = 'SATCriticalReading', label = 'Input SAT Critical Reading Score', value = NA),
             #numericInput(inputId = 'SATWriting', label = 'Input SAT Writing Score', value=NA),
             # Input ACT Scores
             numericInput(inputId = 'ACTEnglish', label = 'Input ACT English Score', value=NA),
             numericInput(inputId = 'ACTMath', label = 'Input ACT Math Score', value=NA)
             #numericInput(inputId = 'ACTWriting', label = 'Input ACT Writing Score', value=NA)
      ),
      column(5,  # First Generation
             br(),
             radioButtons(inputId = 'firstGeneration', label = 'First Generation?', choices = c('Yes', 'No')),
             br(),
             # Sex
             radioButtons(inputId = 'sex', label = 'Select Sex', choices = c('Male', 'Female'))
      )
    ),
    sliderInput('range',
                label = 'I dont know yet: ',
                min = 0, max =100, value = c(0, 100)),
    
    actionButton("action", label= 'Go'),
    br()
    )
  ),
  # Main Panel
  sidebarLayout(
    sidebarPanel(h2('Colleges in your state'),
                 plotOutput('mapState'),
                 h4('Please enter an ID you would like more information:'),
                 numericInput(inputId = 'schoolID', label = 'ID', value = NA)
    ),
    mainPanel(h1('Here are the schools we recommend. Choose one to proceed:'),
              textOutput('text1'),
              textOutput('text2'),
              p('We take into consideration of'),
              DT::dataTableOutput('table')
    )
  ),
  mainPanel(
    textOutput('text3'),
    DT::dataTableOutput('schoolTable')
  )
)
# Define server logic required to draw a histogram
server = function(input, output) {
  output$text1 = renderText({
    paste('Welcome, student from', input$state)
  })
  output$text2 = renderText({
    paste('So we see that you selected a range from,',
          input$range[1], ' to ', input$range[2])
  })
  output$text3 = renderText({
    id = input$schoolID
    name = dummyScore$INSTNM[dummyScore$UNITID == id]
    if (is.na(name)) {
      paste('Waiting for choice')
    } else {
      paste('Following are the information for', name
      )
    }
  })
  
  output$mapNational = renderPlot({
    plotGeo('None', dummyScore)
  })
  
  output$mapState = renderPlot({
    stateName = input$state
    dummyNewScore =  calculateScores(dummy, input$familyIncome, input$firstGeneration, useDefaultWeights = FALSE)
    plotGeo(stateName, dummyNewScore)
  })
  
  output$table = DT::renderDataTable(DT::datatable({
    stateName = input$state
    income = input$familyIncome
    firstGen = input$firstGeneration
    dummyNewScore = calculateScores(dummy, input$familyIncome, input$firstGeneration, useDefaultWeights = FALSE)
    schoolRanking = makeRankingTable(dummyNewScore, stateName, income, firstGen)
  }))
  
  output$schoolTable = DT::renderDataTable(DT::datatable({
    id = input$schoolID
    stateName = input$state
    ethnicity = input$ethnicity
    income = input$familyIncome
    satMath = input$SATMath
    satCR = input$SATCriticalReading
    actEng = input$ACTEnglish
    actMath = input$ACTMath
    schoolTable = makeSchoolTable(dummy, college, id, stateName, ethnicity, income, satMath, satCR, actEng, actMath)
  }))
  }

# Run the application 
shinyApp(ui = ui, server = server)

