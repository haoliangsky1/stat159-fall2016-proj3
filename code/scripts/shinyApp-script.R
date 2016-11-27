#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj3/")
library(ggplot2)
library(stringr)
library(shiny)

college = read.csv('data/mergedData.csv')
stateList = college$STABBR

ui = fluidPage(
	# Select a state
	selectInput(inputId = 'state', label = 'Choose a State', choices = stateList)
	plotOutput('plot')
	# Select an intended major
	selectInput(inputId = 'intendedMajor', label = 'Choose an intended major', choices = )
	# Select financial aid level
	selectInput(inputId = 'financialAid', label = 'Choose a financial aid level', choices = )
	# Select 
	)

server = function(input, output) {
	output$scatterplot  = renderPlot({
		name = input$state
		})
}

shinyApp(ui = ui, server = server)



