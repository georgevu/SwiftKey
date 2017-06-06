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
  prediction <- reactive({
    if (endsWith(input$phrase, " ")) {
      predict(input$phrase)
    }
  })
  output$predict1 <- renderText({prediction()[1]})
  output$predict2 <- renderText({prediction()[2]})
  output$predict3 <- renderText({prediction()[3]})
  output$predict4 <- renderText({prediction()[4]})
  output$prediction <- renderPrint({
    prediction()
  })
  outputOptions(output, "predict1", suspendWhenHidden=FALSE)
  outputOptions(output, "predict2", suspendWhenHidden=FALSE)
  outputOptions(output, "predict3", suspendWhenHidden=FALSE)
  outputOptions(output, "predict4", suspendWhenHidden=FALSE)
})
