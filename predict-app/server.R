#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(quanteda)
library(data.table)
source('predict.R', local=FALSE)

shinyServer(function(input, output) {
  
  prediction <- reactive({predict(input$phrase)})
  if (length(prediction) > 0) {
    output$predict1 <- renderText({prediction()[1]})
  }
  if (length(prediction) > 1) {
    output$predict1 <- renderText({prediction()[2]})
  }
  if (length(prediction) > 2) {
    output$predict1 <- renderText({prediction()[3]})
  }
  if (length(prediction) > 3) {
    output$predict1 <- renderText({prediction()[4]})
  }
})
