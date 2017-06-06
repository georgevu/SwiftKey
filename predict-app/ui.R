#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram

shinyUI(fluidPage(theme=shinytheme("superhero"),
  
  # Application title
  titlePanel("Text Prediction"),
  fluidRow(
    column(12, wellPanel(
      textInput("phrase", "Start Typing"),
      div(style="display:inline-block;background-color:black;border:1px solid darkblue;padding: 5px", conditionalPanel(condition="output.predict1 != 'NA'", textOutput("predict1"))),
      div(style="display:inline-block;background-color:black;border:1px solid darkblue;padding: 5px", conditionalPanel(condition="output.predict2 != 'NA'", textOutput("predict2"))), 
      div(style="display:inline-block;background-color:black;border:1px solid darkblue;padding: 5px", conditionalPanel(condition="output.predict3 != 'NA'", textOutput("predict3"))), 
      div(style="display:inline-block;background-color:black;border:1px solid darkblue;padding: 5px", conditionalPanel(condition="output.predict4 != 'NA'", textOutput("predict4")))
    ))
  ),
  helpText(h3("Text Prediction Application Help"), br(), 
            "This application will attempt to predict what the next word you will type.", br(),
            "As you type wait after typing the space key to get a prediction for the next word.", br(),
            "Be patient after typing if you want the next word prediction since it may take a few seconds."
           )
))
