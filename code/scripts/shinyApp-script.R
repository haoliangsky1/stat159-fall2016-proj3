#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#setwd("C:/Users/andre/Dropbox/College/Fall 16/Stat159/stat159-fall2016-proj3")
library(stringr)
library(shiny)
library(plyr)
library(maps)
library(ggplot2)
library(grDevices)
library(leaflet)

dummyScore = read.csv('../../data/schoolRanking.csv')

# Preparing data for the ggplot:
stateList = college$STABBR
all_states = map_data('state')
all_states[]









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
  actionButton("action", label= 'Go'),
  br()
  
#  plot('plot')
  #plotOutput('plot'),
	)
p = ggplot()
p = p + geom_polygon(data = all_states[all_states$region == 'california',], 
                     aes(x=long, y= lat, group = group), color = 'white')
temp = dummyScore[dummyScore$STABBR == stateName, ]
temp = temp[order(-temp$Score), ]
p = p + geom_point(data = temp[1:20,], aes(x = LONGITUDE, y = LATITUDE, size = Score),
                   color = 'red') + scale_size(name = 'Score')
p

shinyServer = function(input, output) {
  stateName =input$state
  output$plot = renderPlot({
    stateName = input$state
    plotGeo()
  })


  
  # First make a graph of the choice of state:
	#output$plot  = renderPlot({
	#  stateName = input$state
	#	})
}

plotGeo = function(){
  map = get_map(location = 'North America', zoom =4)
  mapPoints = ggmap(map) +
    geom_point(data = dummyScore, aes(x = LONGITUDE, y = LATITUDE, size= Score), alpha = .3,
               color = 'red') + scale_size(name = 'Score') 
  
  mapPoints
}


shinyApp(ui = shinyUI, server = shinyServer)



