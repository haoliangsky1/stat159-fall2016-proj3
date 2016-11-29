#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
#setwd("C:/Users/andre/Dropbox/College/Fall 16/Stat159/stat159-fall2016-proj3")
library(ggplot2)
library(stringr)
library(shiny)

college = read.csv('data/combinedData.csv')
stateList = college$STABBR

ui = fluidPage(
	# Select a state
	selectInput(inputId = 'state', label = 'Choose a State', choices = sort(stateList)),
	plotOutput('plot'),
	# Select an intended major
	selectInput(inputId = 'intendedMajor', label = 'Choose an intended major', 
	            choices = c('Computer Science','Literature','Mathematics','Engineering','Social Studies','Visual and Perfoming Arts','Business','History')),
	# Select financial aid level
	selectInput(inputId = 'familyIncome', label = 'Choose family income level', 
	            choices = c('$0-$30,000','$30,001-$48,000','$48,001-$75,000','$75,001-$110,000','$110,000+'))
	# Select 
	)

server = function(input, output) {
	output$scatterplot  = renderPlot({
		name = input$state
		})
}

shinyApp(ui = ui, server = server)



